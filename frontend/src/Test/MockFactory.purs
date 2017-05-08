-- | Helper functions to mock data.
-- |
-- | _Note_: All these functions are used for testing only.

module Explorer.Test.MockFactory where

import Prelude
import Data.Lens (set)
import Data.Maybe (Maybe(..))
import Data.Time.NominalDiffTime (NominalDiffTime, mkTime)
import Explorer.Util.Factory (mkCAddress, mkCHash, mkCTxId, mkCoin)
import Pos.Explorer.Web.ClientTypes (CAddressSummary(..), CBlockEntry(..), CHash, CTxEntry(..), CTxId)
import Pos.Explorer.Web.Lenses.ClientTypes (_CBlockEntry, _CTxEntry, cbeBlkHash, cbeEpoch, cbeSlot, cbeTimeIssued, cteId, cteTimeIssued)

-- | Creates a `CTxEntry` with "empty" data
mkEmptyCTxEntry :: CTxEntry
mkEmptyCTxEntry = CTxEntry
    { cteId: mkCTxId "--"
    , cteTimeIssued: mkTime 0.0
    , cteAmount: mkCoin 0
    }

-- | Update hash of a transcation
setIdOfTx :: CTxId -> CTxEntry -> CTxEntry
setIdOfTx txId tx =
    set (_CTxEntry <<< cteId) txId tx

-- | Update time of a transaction
setTimeOfTx :: NominalDiffTime -> CTxEntry -> CTxEntry
setTimeOfTx time tx =
    set (_CTxEntry <<< cteTimeIssued) time tx

mkEmptyCAddressSummary :: CAddressSummary
mkEmptyCAddressSummary = CAddressSummary
    { caAddress: mkCAddress "--"
    , caTxNum: 0
    , caBalance: mkCoin 0
    , caTxList: []
    }

mkCBlockEntry :: CBlockEntry
mkCBlockEntry = CBlockEntry
    { cbeEpoch: 0
    , cbeSlot: 0
    , cbeBlkHash: mkCHash "0"
    , cbeTimeIssued: Nothing
    , cbeTxNum: 0
    , cbeTotalSent: mkCoin 0
    , cbeSize: 0
    , cbeRelayedBy: Nothing
    }


-- | Update time of a slot
setTimeOfBlock :: NominalDiffTime -> CBlockEntry -> CBlockEntry
setTimeOfBlock time block =
    set (_CBlockEntry <<< cbeTimeIssued) (Just time) block

-- | Update slot / epoch of a slot
setEpochSlotOfBlock :: Int -> Int -> CBlockEntry -> CBlockEntry
setEpochSlotOfBlock epoch slot block =
    set (_CBlockEntry <<< cbeEpoch) epoch $
    set (_CBlockEntry <<< cbeSlot) slot block

-- | Update hash of a slot
setHashOfBlock :: CHash -> CBlockEntry -> CBlockEntry
setHashOfBlock hash block =
    set (_CBlockEntry <<< cbeBlkHash) hash block