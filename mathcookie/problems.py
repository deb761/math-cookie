"""Define problem types and problems"""
from enum import Enum
import math

class ProblemType(Enum):
    ADDITION = 1
    SUBTRACTION = 2
    PLACE = 3
    POSITION = 4

def pyramid_count(n):
    """Return the number of elements in a pyramid with n items in the largest row"""
    return int((n * (n + 1)) / 2)

def pyramid_position(x):
    """Find the row and offset of x from the pyramid apex"""
    row = int((-1 + math.sqrt(1 + 8 * (x - 1))) / 2) + 1
    count = pyramid_count(row)
    return row, x - count + row - 1


class Problem(object):
    """A student problem with level, type, operands, and result"""

    def __init__(self, id=0, level=0, problem_type=None, operand1=-1, operand2=-1):
        """Determine the problem by its id.  The id is divided into bits, with bit 0 as MSB:

        - 00-03 level
        - 04-07 type
        - 08-15 operand1
        - 16-23 operand2
        - 24-31 result

        :param int id: problem ID, if supplied, level, type, operands, and result are derived from this
        :param int level: level
        :param ProblemType type: Problem type
        :param int operand1: First operand
        :param int operand2: Second operand
        """
        if id > 0:
            self.id = id
            self.level = (id & 0xf0000000) >> 28
            self.problem_type = ProblemType((id & 0x0f000000) >> 24)
            self.operand1 = (id & 0x00ff0000) >> 16
            self.operand2 = (id & 0x0000ff00) >> 8
            self.result = id & 0x000000ff

        else:
            if not level or not problem_type or operand1 < 0 or operand2 < 0:
                raise Exception("level, problem_type, operand1 and operand2 are all required if id == 0")

            self.level = level
            self.problem_type = problem_type
            self.operand1 = int(operand1)
            self.operand2 = int(operand2)
            self.calc_result()
            self.set_id()


    def set_id(self):
        """Fill in the id"""
        self.id = (self.level << 28) | (self.problem_type.value << 24) | (self.operand1 << 16)
        self.id |= (int(self.operand2) << 8) | self.result


    def calc_result(self):
        """Get the result for a problem"""
        if self.problem_type == ProblemType.ADDITION:
            self.result = self.operand1 + self.operand2
        elif self.problem_type == ProblemType.SUBTRACTION:
            self.result = self.operand1 - self.operand2
        elif self.problem_type == ProblemType.PLACE:
            self.result = str(self.operand1)[self.operand2 - 1]
        else:
            string = str(self.operand1)
            self.result = 10 ** (len(string) - string.find(str(self.operand2)) - 1)


    @staticmethod
    def create(level, problem_type, num):
        """Create a problem in the range of possible problems for the level and problem type"""
        if level == 1:
            if problem_type == ProblemType.ADDITION:
                return Level1Addition(num)
            return Level1Subtraction(num)

    DECADE = 10
    PYRAMID_COUNT_10 = pyramid_count(10)
    PYRAMID_COUNT_79 = pyramid_count(79)
    PYRAMID_COUNT_80 = pyramid_count(80)
    PYRAMID_COUNT_90 = pyramid_count(90)

    @staticmethod
    def possible(level, problem_type):
        return Problem.COUNTS[level][problem_type]


    def __repr__(self):
        return "<Problem 'level={}, {} {} {} = {}'>".format(
            self.level, self.operand1, self.problemtype.name, self.operand2, self.result)


class Level1Addition(Problem):
    """A level 1 Addition problem"""
    COUNT = Problem.PYRAMID_COUNT_10
    def __init__(self, num):
        row, self.operand2 = pyramid_position(num)
        self.operand1 = 10 - row
        self.result = self.operand1 + self.operand2
        self.problem_type = ProblemType.ADDITION
        self.level = 1
        self.set_id()


class Level1Subtraction(Problem):
    """A level 1 Addition problem

    - 1 problem with 0 as the first operand
    - 2 problems with 1 as the first operand
    - ...
    - 10 problems with 9 as the first operand
    """
    COUNT = Problem.PYRAMID_COUNT_10
    def __init__(self, num):
        row, self.operand2 = pyramid_position(num)
        self.operand1 = row - 1
        self.level = 1
        self.problem_type = ProblemType.SUBTRACTION
        self.result = self.operand1 - self.operand2
        self.set_id()


class Level2Addition(Problem):
    """Addition of one 1 digit number and one 2 digit number with sum less than 100

    - 1 problem with 99 as the first operand
    - ...
    - 9 problems with 91 as the first operand
    - 10 problems with 10 as the first operand (first pyramid of 10)

    - 10 problems each with 11 ... 90 as the first operand (next 800)

    - 81 problems with 9 as the first operand (next pyramid(90) - pyramid(80))
    - ...
    - 89 problems with 1 as the first operand
    - 90 problems with 0 as the first operand (second operand 10 - 99)

    """
    SECTION1_COUNT = Problem.PYRAMID_COUNT_10
    SECTION2_COUNT = (90 - 11 + 1) * Problem.DECADE
    SECTION3_COUNT = Problem.PYRAMID_COUNT_90 - Problem.PYRAMID_COUNT_80
    COUNT = SECTION1_COUNT + SECTION2_COUNT + SECTION3_COUNT

    def __init__(self, num):
        if num <= Level2Addition.SECTION1_COUNT:
            row, self.operand2 = pyramid_position(num)
            self.operand1 = 100 - row

        elif num - Level2Addition.SECTION1_COUNT <= Level2Addition.SECTION2_COUNT:
            offset = num - Level2Addition.SECTION1_COUNT - 1
            self.operand1 = int(offset / Problem.DECADE) + 11
            self.operand2 = offset % Problem.DECADE

        else:
            offset = num - Level2Addition.SECTION1_COUNT - Level2Addition.SECTION2_COUNT
            row, offset = pyramid_position(offset + Problem.PYRAMID_COUNT_80)
            self.operand1 = Problem.DECADE - (row - 81) - 1
            self.operand2 = offset + Problem.DECADE

        self.result = self.operand1 + self.operand2
        self.problem_type = ProblemType.ADDITION
        self.level = 2
        self.set_id()


class Level2Subtraction(Problem):
    """Subtraction of a 1 digit number from a two digit number

    - 10 problems each with 10 ... 99 as the first number
    """
    COUNT = Problem.DECADE * (90)

    def __init__(self, num):
        self.operand1 = int((num - 1) / Problem.DECADE) + Problem.DECADE
        self.operand2 = (num - 1) % Problem.DECADE
        self.level = 2
        self.problem_type = ProblemType.SUBTRACTION
        self.result = self.operand1 - self.operand2
        self.set_id()


class Level3Addition(Problem):
    """Addition of two 2-digit numbers with sum less than 100

    - 1 problem with 89 as the first operand
    - ...
    - 79 problems with 11 as the first operand
    - 80 problems with 10 as the first operand
    """
    COUNT = pyramid_count(80)
    MAX_OP1 = 99 - Problem.DECADE

    def __init__(self, num):
        row, offset = pyramid_position(num)
        self.operand1 = Level3Addition.MAX_OP1 - row + 1
        self.operand2 = offset + Problem.DECADE

        self.result = self.operand1 + self.operand2
        self.problem_type = ProblemType.ADDITION
        self.level = 3
        self.set_id()


class Level3Subtraction(Problem):
    """Subtraction of two 2-digit numbers with positive result

    - 1 problem with 10 as the first operand
    - 2 problems with 11 as the first operand
    - ...
    - 90 problems with 99 as the first operand
    """
    COUNT = pyramid_count(90)

    def __init__(self, num):
        row, offset = pyramid_position(num)
        self.operand1 = row + Problem.DECADE - 1
        self.operand2 = offset + Problem.DECADE

        self.level = 3
        self.problem_type = ProblemType.SUBTRACTION
        self.result = self.operand1 - self.operand2
        self.set_id()


class Level2Place(Problem):
    """Quiz on place value for a digit in a two-digit number

    - 9 problems each for 1..9 in the tens place
    - repeated for each value in the ones place
    """
    COUNT_MATE = Problem.DECADE - 1
    COUNT_VALUES = COUNT_MATE * COUNT_MATE
    COUNT = COUNT_VALUES * 2

    def __init__(self, num):
        """Determine the problem from num:

        - 9 problems for each 1 .. 9 in the tens place
        - repeated for each value in the ones place
        """
        slot = int(num / Level3Place.COUNT_VALUES)
        self.result = 10 ** slot

        offset = num % Level2Place.COUNT_VALUES
        tens = int(offset / Level2Place.COUNT_MATE) + 1
        ones = offset % Level2Place.COUNT_MATE

        if ones >= tens:
            ones += 1

        self.level = 2
        self.problem_type = ProblemType.PLACE
        self.operand1 = tens * Problem.DECADE + ones
        self.operand2 = ones if self.result == 1 else tens

        self.set_id()


class Level3Place(Problem):
    """Quiz on place value for a digit in a three-digit number

    - 9 * 8 problems each for 1..9 in the hundreds place
    - repeated three times for each place
    """
    COUNT_MATE = Problem.DECADE - 1
    COUNT_MATE2 = COUNT_MATE - 1
    COUNT_MATES = COUNT_MATE * COUNT_MATE2
    COUNT_VALUES = COUNT_MATE * COUNT_MATE2
    COUNT = COUNT_VALUES * 3
    TENS_END = 2 * COUNT_VALUES

    def __init__(self, num):
        """Determine the problem from num:

        - 1 ... 90 for 0..9 in ones place
        - 91 ... 171 for 1..9 in tens place
        """
        slot = int(num / Level3Place.COUNT_VALUES)
        self.result = 10 ** slot

        num = num % Level3Place.COUNT_VALUES

        hundreds = int(num / Level3Place.COUNT_MATES) + 1
        remainder = num % Level3Place.COUNT_MATES
        tens = int(remainder / Level3Place.COUNT_MATE2)
        ones = remainder % Level3Place.COUNT_MATE2

        if tens >= hundreds:
            tens += 1

        if ones >= min(hundreds, tens):
            ones += 1

        if ones >= max(hundreds, tens):
            ones += 1

        self.level = 3
        self.problem_type = ProblemType.PLACE
        self.operand1 = hundreds * Problem.DECADE * Problem.DECADE + tens * Problem.DECADE + ones
        if self.result == 1:
            self.operand2 = ones
        elif self.result == 10:
            self.operand2 = tens
        else:
            self.operand2 = hundreds

        self.set_id()


class Level2Position(Level2Place):
    """Problem asks the digit in a position"""
    def __init__(self, num):
        super(Level2Place, num)
        pos = self.result
        self.result = self.operand2
        self.operand2 = pos
        self.problem_type = ProblemType.POSITION
        self.set_id()


class Level3Position(Level3Place):
    """Problem asks the digit in a position"""
    def __init__(self, num):
        super(Level3Place, num)
        pos = self.result
        self.result = self.operand2
        self.operand2 = pos
        self.problem_type = ProblemType.POSITION
        self.set_id()


class ProblemFactory(object):
    """A problem factory class"""
    
    COUNTS = {
        1 : {
            ProblemType.ADDITION : Level1Addition.COUNT,
            ProblemType.SUBTRACTION : Level1Subtraction.COUNT
        },
        2: {
            ProblemType.ADDITION : Level2Addition.COUNT,
            ProblemType.SUBTRACTION : Level2Subtraction.COUNT,
            ProblemType.PLACE : Level2Place.COUNT,
            ProblemType.POSITION : Level2Position.COUNT
        },
        3: {
            ProblemType.ADDITION : Level3Addition.COUNT,
            ProblemType.SUBTRACTION : Level3Subtraction.COUNT,
            ProblemType.PLACE : Level3Place.COUNT,
            ProblemType.POSITION : Level3Position.COUNT
        }
    }
    def count(level, problem_type):
        return ProblemFactory.COUNTS[level][problem_type]
    
    PROBLEMS = {
        1 : {
            ProblemType.ADDITION : Level1Addition,
            ProblemType.SUBTRACTION : Level1Subtraction
        },
        2: {
            ProblemType.ADDITION : Level2Addition,
            ProblemType.SUBTRACTION : Level2Subtraction,
            ProblemType.PLACE : Level2Place,
            ProblemType.POSITION : Level2Position
        },
        3: {
            ProblemType.ADDITION : Level3Addition,
            ProblemType.SUBTRACTION : Level3Subtraction,
            ProblemType.PLACE : Level3Place,
            ProblemType.POSITION : Level3Position
        }
    }
    def create(level, problem_type, num):
        return ProblemFactory.PROBLEMS[level][problem_type](num)
