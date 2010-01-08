-- @+leo-ver=4-thin
-- @+node:gcross.20100107191635.1519:@thin tests/test.hs
-- @@language Haskell

-- @<< Language extensions >>
-- @+node:gcross.20100107191635.1520:<< Language extensions >>
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE Rank2Types #-}
-- @-node:gcross.20100107191635.1520:<< Language extensions >>
-- @nl

-- @<< Import needed modules >>
-- @+node:gcross.20100107191635.1521:<< Import needed modules >>
import Debug.Trace

import Test.HUnit
import Test.Framework
import Test.Framework.Providers.HUnit
import Test.Framework.Providers.QuickCheck2
import Test.Framework.Providers.AntiTest
import Test.QuickCheck
-- @-node:gcross.20100107191635.1521:<< Import needed modules >>
-- @nl

-- @+others
-- @+node:gcross.20100107191635.1777:Functions
-- @+node:gcross.20100107191635.1778:echo
echo x = trace (show x) x
-- @-node:gcross.20100107191635.1778:echo
-- @-node:gcross.20100107191635.1777:Functions
-- @-others

main = defaultMain
    -- @    << Tests >>
    -- @+node:gcross.20100107191635.1611:<< Tests >>
    -- @+others
    -- @+node:gcross.20100107191635.1614:simplest case
    [antiTest $ testCase "simplest case" $ assertFailure ""
    -- @-node:gcross.20100107191635.1614:simplest case
    -- @+node:gcross.20100107191635.1813:anti's cancel
    ,antiTest $ antiTest $ testCase "antiTests cancel" $ return ()
    -- @-node:gcross.20100107191635.1813:anti's cancel
    -- @+node:gcross.20100107191635.1814:non-tautology
    ,antiTest $ testProperty "not a tautology" $ (id :: Bool -> Bool)
    -- @-node:gcross.20100107191635.1814:non-tautology
    -- @-others
    -- @-node:gcross.20100107191635.1611:<< Tests >>
    -- @nl
    ]
-- @-node:gcross.20100107191635.1519:@thin tests/test.hs
-- @-leo
