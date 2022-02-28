from scripts.helper_scripts import get_account
from brownie import Minter

token_uri = "https://ipfs.io/ipfs/QmVBwKkVxeDLu6jB2A714rcD7b827Uc1JVYkLafTnrd8sp?filename=karl.json"
OPENSEA_URL = "https://testnets.opensea.io/assets/{}/{}"


def deploy():
    account = get_account()
    simple_collectible = Minter.deploy({"from": account})
    transaction = simple_collectible.createCollectible(token_uri, {"from": account})
    transaction.wait(1)
    print(f"View your NFT at {OPENSEA_URL.format(simple_collectible.address, simple_collectible.tokenCounter() -1)}")
    return simple_collectible

def main():
    deploy()