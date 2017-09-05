"""Rules for the levels and rounds"""
import json
import os


class Level(object):
    """A lesson level"""
    def __init__(self, level_def):
        self.__dict__ = {k.lower() : v for k, v in level_def.items()}
        self.rounds = [Round(x) for x in self.rounds]


class Round(object):
    """A lesson round"""
    def __init__(self, round_def):
        self.__dict__ = {k.lower() : v for k, v in round_def.items()}


# Load the level/round rules
SITE_ROOT = os.path.realpath(os.path.dirname(__file__))
json_path = os.path.join(SITE_ROOT, "static/data", "rules.json")
levels = [Level(x) for x in json.load(open(json_path))]
