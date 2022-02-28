
from scripts.helper_scripts import LOCAL_BLOCKCHAIN_ENVIRONMENTS, get_account
from brownie import network
from scripts.deploy import deploy
import pytest


def test_can_create():
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip()
    simple_collectible = deploy()
    assert simple_collectible.ownerOf(0) == get_account()
