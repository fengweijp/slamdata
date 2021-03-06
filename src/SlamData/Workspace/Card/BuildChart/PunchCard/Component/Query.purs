{-
Copyright 2016 SlamData, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-}

module SlamData.Workspace.Card.BuildChart.PunchCard.Component.Query where

import SlamData.Prelude

import Data.Argonaut (JCursor)

import Halogen as H

import SlamData.Workspace.Card.Common.EvalQuery (CardEvalQuery)
import SlamData.Workspace.Card.BuildChart.Aggregation (Aggregation)
import SlamData.Workspace.Card.BuildChart.Inputs (SelectAction)
import SlamData.Workspace.Card.BuildChart.PunchCard.Component.ChildSlot (ChildQuery, ChildSlot)

data Selection f
  = Abscissa (f JCursor)
  | Ordinate (f JCursor)
  | Value (f JCursor)
  | ValueAgg (f Aggregation)

data Query a
  = Select (Selection SelectAction) a
  | ToggleCircularLayout a
  | SetMinSymbolSize String a
  | SetMaxSymbolSize String a

type QueryC = CardEvalQuery ⨁ Query

type QueryP = QueryC ⨁ H.ChildF ChildSlot ChildQuery
