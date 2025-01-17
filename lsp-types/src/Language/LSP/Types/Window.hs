{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE DuplicateRecordFields      #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TemplateHaskell            #-}
module Language.LSP.Types.Window where

import qualified Data.Aeson                                 as A
import           Data.Aeson.TH
import           Data.Text                                  (Text)
import           Language.LSP.Types.Utils
import Language.LSP.Types.Uri
import Language.LSP.Types.Location

-- ---------------------------------------------------------------------

data MessageType = MtError   -- ^ Error = 1,
                 | MtWarning -- ^ Warning = 2,
                 | MtInfo    -- ^ Info = 3,
                 | MtLog     -- ^ Log = 4
        deriving (Eq,Ord,Show,Read,Enum)

instance A.ToJSON MessageType where
  toJSON MtError   = A.Number 1
  toJSON MtWarning = A.Number 2
  toJSON MtInfo    = A.Number 3
  toJSON MtLog     = A.Number 4

instance A.FromJSON MessageType where
  parseJSON (A.Number 1) = pure MtError
  parseJSON (A.Number 2) = pure MtWarning
  parseJSON (A.Number 3) = pure MtInfo
  parseJSON (A.Number 4) = pure MtLog
  parseJSON _            = fail "MessageType"

-- ---------------------------------------


data ShowMessageParams =
  ShowMessageParams {
    _xtype   :: MessageType
  , _message :: Text
  } deriving (Show, Read, Eq)

deriveJSON lspOptions ''ShowMessageParams

-- ---------------------------------------------------------------------

data MessageActionItem =
  MessageActionItem
    { _title :: Text
    } deriving (Show,Read,Eq)

deriveJSON lspOptions ''MessageActionItem


data ShowMessageRequestParams =
  ShowMessageRequestParams
    { _xtype   :: MessageType
    , _message :: Text
    , _actions :: Maybe [MessageActionItem]
    } deriving (Show,Read,Eq)

deriveJSON lspOptions ''ShowMessageRequestParams

-- ---------------------------------------------------------------------

-- | Params to show a document.
--
-- @since 3.16.0
data ShowDocumentParams =
  ShowDocumentParams {
    -- | The document uri to show.
    _uri :: Uri

    -- | Indicates to show the resource in an external program.
    -- To show for example `https://code.visualstudio.com/`
    -- in the default WEB browser set `external` to `true`.
  , _external :: Maybe Bool

    -- | An optional property to indicate whether the editor
    -- showing the document should take focus or not.
    -- Clients might ignore this property if an external
    -- program is started.
  , _takeFocus :: Maybe Bool

    -- | An optional selection range if the document is a text
    -- document. Clients might ignore the property if an
    -- external program is started or the file is not a text
    -- file.
  , _selection :: Maybe Range
  } deriving (Show, Read, Eq)

deriveJSON lspOptions ''ShowDocumentParams

-- | The result of an show document request.
--
--  @since 3.16.0
data ShowDocumentResult =
  ShowDocumentResult {
    -- | A boolean indicating if the show was successful.
    _success :: Bool
  } deriving (Show, Read, Eq)

deriveJSON lspOptions ''ShowDocumentResult

-- ---------------------------------------------------------------------

data LogMessageParams =
  LogMessageParams {
    _xtype   :: MessageType
  , _message :: Text
  } deriving (Show, Read, Eq)

deriveJSON lspOptions ''LogMessageParams
