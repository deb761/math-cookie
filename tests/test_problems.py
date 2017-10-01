import pytest
import mathcookie.problems as problems

testdata = [
    (0, 0), (1, 1), (2, 3), (3, 6), (10, 55)
]

@pytest.mark.parametrize("n, expected", testdata)
def test_pyramid_count(n, expected):
    result = problems.pyramid_count(n)
    assert result == expected


@pytest.mark.parametrize("n, expected", [
    (1, (1, 0)), (2, (2, 0)), (3, (2, 1)), (10, (4, 3))
    ])
def test_pyramid_row_offset(n, expected):
    result = problems.pyramid_position(n)
    assert result == expected


@pytest.mark.parametrize("n, expected", [
    (1, {'id' : 0x11090009, 'level' : 1, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 9,
         'operand2' : 0, 'result' : 9}),
    (2, {'id' : 0x11080008, 'level' : 1, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 8,
         'operand2' : 0, 'result' : 8}),
    (12, {'id' : 0x11050106, 'level' : 1, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 5,
         'operand2' : 1, 'result' : 6}),
    (36, {'id' : 0x11020709, 'level' : 1, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 2,
         'operand2' : 7, 'result' : 9}),
    (55, {'id' : 0x11000909, 'level' : 1, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 0,
         'operand2' : 9, 'result' : 9})
    ])
def test_create_level1_addition(n, expected):
    result = problems.Level1Addition(n)
    assert result.__dict__ == expected


@pytest.mark.parametrize("n, expected", [
    (1, {'id' : 0x12000000, 'level' : 1, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 0,
         'operand2' : 0, 'result' : 0}),
    (2, {'id' : 0x12010001, 'level' : 1, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 1,
         'operand2' : 0, 'result' : 1}),
    (12, {'id' : 0x12040103, 'level' : 1, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 4,
         'operand2' : 1, 'result' : 3}),
    (36, {'id' : 0x12070700, 'level' : 1, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 7,
         'operand2' : 7, 'result' : 0}),
    (55, {'id' : 0x12090900, 'level' : 1, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 9,
         'operand2' : 9, 'result' : 0})
    ])
def test_create_level1_subtraction(n, expected):
    result = problems.Level1Subtraction(n)
    assert result.__dict__ == expected


@pytest.mark.parametrize("n, expected", [
    (1, {'id' : 0x21630063, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 99,
         'operand2' : 0, 'result' : 99}),
    (2, {'id' : 0x21620062, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 98,
         'operand2' : 0, 'result' : 98}),
    (12, {'id' : 0x215f0160, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 95,
         'operand2' : 1, 'result' : 96}),
    (36, {'id' : 0x215c0763, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 92,
         'operand2' : 7, 'result' : 99}),
    (55, {'id' : 0x215a0963, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 90,
         'operand2' : 9, 'result' : 99}),
    (56, {'id' : 0x210b000b, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 11,
         'operand2' : 0, 'result' : 11}),
    (65, {'id' : 0x210b0914, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 11,
         'operand2' : 9, 'result' : 20}),
    (100, {'id' : 0x210f0413, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 15,
         'operand2' : 4, 'result' : 19}),
    (855, {'id' : 0x215a0963, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 90,
         'operand2' : 9, 'result' : 99}),
    (856, {'id' : 0x21090a13, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 9,
         'operand2' : 10, 'result' : 19}),
    (936, {'id' : 0x21095a63, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 9,
         'operand2' : 90, 'result' : 99}),
    (937, {'id' : 0x21080a12, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 8,
         'operand2' : 10, 'result' : 18}),
    (1621, {'id' : 0x21000a0a, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 0,
         'operand2' : 10, 'result' : 10}),
    (1710, {'id' : 0x21006363, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 0,
         'operand2' : 99, 'result' : 99}),
    ])
def test_create_level2_addition(n, expected):
    result = problems.Level2Addition(n)
    assert result.__dict__ == expected


@pytest.mark.parametrize("n, expected", [
    (1, {'id' : 0x220a000a, 'level' : 2, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 10,
         'operand2' : 0, 'result' : 10}),
    (2, {'id' : 0x220a0109, 'level' : 2, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 10,
         'operand2' : 1, 'result' : 9}),
    (12, {'id' : 0x220b010a, 'level' : 2, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 11,
         'operand2' : 1, 'result' : 10}),
    (36, {'id' : 0x220d0508, 'level' : 2, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 13,
         'operand2' : 5, 'result' : 8}),
    (55, {'id' : 0x220f040b, 'level' : 2, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 15,
         'operand2' : 4, 'result' : 11}),
    (900, {'id' : 0x2263095a, 'level' : 2, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 99,
         'operand2' : 9, 'result' : 90})
    ])
def test_create_level2_subtraction(n, expected):
    result = problems.Level2Subtraction(n)
    assert result.__dict__ == expected


@pytest.mark.parametrize("n, expected", [
    (1, {'id' : 0x31590a63, 'level' : 3, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 89,
         'operand2' : 10, 'result' : 99}),
    (2, {'id' : 0x31580a62, 'level' : 3, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 88,
         'operand2' : 10, 'result' : 98}),
    (3, {'id' : 0x31580b63, 'level' : 3, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 88,
         'operand2' : 11, 'result' : 99}),
    (56, {'id' : 0x314f0a59, 'level' : 3, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 79,
         'operand2' : 10, 'result' : 89}),
    (66, {'id' : 0x314f1463, 'level' : 3, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 79,
         'operand2' : 20, 'result' : 99}),
    (3240, {'id' : 0x310a5963, 'level' : 3, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 10,
         'operand2' : 89, 'result' : 99}),
    ])
def test_create_level3_addition(n, expected):
    result = problems.Level3Addition(n)
    assert result.__dict__ == expected


@pytest.mark.parametrize("n, expected", [
    (1, {'id' : 0x320a0a00, 'level' : 3, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 10,
         'operand2' : 10, 'result' : 0}),
    (2, {'id' : 0x320b0a01, 'level' : 3, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 11,
         'operand2' : 10, 'result' : 1}),
    (3, {'id' : 0x320b0b00, 'level' : 3, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 11,
         'operand2' : 11, 'result' : 0}),
    (66, {'id' : 0x32141400, 'level' : 3, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 20,
         'operand2' : 20, 'result' : 0}),
    (4090, {'id' : 0x32635e05, 'level' : 3, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 99,
         'operand2' : 94, 'result' : 5}),
    (4095, {'id' : 0x32636300, 'level' : 3, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 99,
         'operand2' : 99, 'result' : 0}),
    ])
def test_create_level2_subtraction(n, expected):
    result = problems.Level3Subtraction(n)
    assert result.__dict__ == expected


@pytest.mark.parametrize("n, expected", [
    (2, {'id' : 0x11080008, 'level' : 1, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 8,
         'operand2' : 0, 'result' : 8}),
    (36, {'id' : 0x12070700, 'level' : 1, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 7,
         'operand2' : 7, 'result' : 0}),
    (56, {'id' : 0x210b000b, 'level' : 2, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 11,
         'operand2' : 0, 'result' : 11}),
    (12, {'id' : 0x220b010a, 'level' : 2, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 11,
         'operand2' : 1, 'result' : 10}),
    (1, {'id' : 0x31590a63, 'level' : 3, 'problem_type' : problems.ProblemType.ADDITION, 'operand1' : 89,
         'operand2' : 10, 'result' : 99}),
    (1, {'id' : 0x320a0a00, 'level' : 3, 'problem_type' : problems.ProblemType.SUBTRACTION, 'operand1' : 10,
         'operand2' : 10, 'result' : 0}),
    ])
def test_create_level2_subtraction(n, expected):
    result = problems.Problem(id=expected['id'])
    assert result.__dict__ == expected
