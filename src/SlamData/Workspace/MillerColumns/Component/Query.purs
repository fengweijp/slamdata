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

module SlamData.Workspace.MillerColumns.Component.Query where

import SlamData.Prelude

import Data.List (List)

import Halogen as H

import DOM.HTML.Types (HTMLElement)

data Query i b
  = Ref (Maybe HTMLElement) b
  | Populate (List i) b
  | Extended b
  | Loading Boolean b

data ItemQuery i b
  = RaisePopulate (List i) b
  | ToggleSelected Boolean b

type ChildQuery i f = Coproduct (ItemQuery i) f

type Query' i f = Coproduct (Query i) (H.ChildF (List i) (ChildQuery i f))
