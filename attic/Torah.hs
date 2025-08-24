import Network.HTTP.Simple
import qualified Data.ByteString.Char8 as B8

main :: IO ()
main = do
  s <- httpBS "https://github.com/ancientlanguage/xml-tanach/blob/master/books/Psalms.xml" . getResponseBody
