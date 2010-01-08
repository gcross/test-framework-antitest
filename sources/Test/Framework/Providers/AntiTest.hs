-- @+leo-ver=4-thin
-- @+node:gcross.20100107191635.1793:@thin sources/Test/Framework/Providers/AntiTest.hs
-- @@language Haskell

-- @<< Language extensions >>
-- @+node:gcross.20100107191635.1794:<< Language extensions >>
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances #-}
-- @-node:gcross.20100107191635.1794:<< Language extensions >>
-- @nl

module Test.Framework.Providers.AntiTest (antiTest) where

-- @<< Import needed modules >>
-- @+node:gcross.20100107191635.1795:<< Import needed modules >>
import Control.Arrow

import Debug.Trace

import Test.Framework.Providers.API

import Text.Printf
-- @-node:gcross.20100107191635.1795:<< Import needed modules >>
-- @nl

-- @+others
-- @+node:gcross.20100107191635.1807:Types
-- @+node:gcross.20100107191635.1806:AntiResult
newtype AntiResult r = AntiResult { unwrapAntiResult :: r }

instance (TestResultlike i r, Show r) => Show (AntiResult r) where
    show (AntiResult r) =
        if testSucceeded r 
            then "Not a failure: " ++ show r
            else "OK - '" ++ show r ++ "'"

instance TestResultlike i r => TestResultlike i (AntiResult r) where
    testSucceeded = not . testSucceeded . unwrapAntiResult
-- @-node:gcross.20100107191635.1806:AntiResult
-- @+node:gcross.20100107191635.1809:AntiTest
newtype AntiTest t = AntiTest { unwrapAntiTest :: t }

instance Testlike i r t => Testlike i (AntiResult r) (AntiTest t) where
    testTypeName = ("Anti-" ++) . testTypeName . unwrapAntiTest
    runTest options = fmap (first (fmap AntiResult)) . runTest options . unwrapAntiTest
-- @-node:gcross.20100107191635.1809:AntiTest
-- @-node:gcross.20100107191635.1807:Types
-- @+node:gcross.20100107191635.1810:Functions
-- @+node:gcross.20100107191635.1811:antiTest
antiTest (Test name test) = Test name (AntiTest test)
antiTest _ = error "Can only apply antiTest to a test case, not to a group or a set of options."
-- @-node:gcross.20100107191635.1811:antiTest
-- @-node:gcross.20100107191635.1810:Functions
-- @-others
-- @-node:gcross.20100107191635.1793:@thin sources/Test/Framework/Providers/AntiTest.hs
-- @-leo
