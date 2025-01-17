module ProgramTest.TestHtmlHacksTest exposing (all)

import Expect
import ProgramTest.TestHtmlHacks as TestHtmlHacks exposing (FailureReason(..))
import Test exposing (..)


all : Test
all =
    describe "ProgramTest.TestHtmlHacks" <|
        [ describe "parseFailureReason"
            [ test "parses a selector error" <|
                \() ->
                    TestHtmlHacks.parseFailureReason
                        "clickButton \"Click Me\":\n▼ Query.fromHtml\n\n    <body>\n        <button disabled=true>\n            Click Me\n        </button>\n    </body>\n\n\n▼ Query.has [ tag \"form\", containing [ tag \"input\", attribute \"type\" \"submit\", attribute \"value\" \"Click Me\" ]  ]\n\n✓ has tag \"form\"\n✗ has containing [ tag \"input\", attribute \"type\" \"submit\", attribute \"value\" \"Click Me\" ] "
                        |> Expect.equal
                            (SelectorsFailed
                                [ Ok "has tag \"form\""
                                , Err "has containing [ tag \"input\", attribute \"type\" \"submit\", attribute \"value\" \"Click Me\" ]"
                                ]
                            )
            ]
        , describe "parseSimulateFailure"
            [ test "parses" <|
                \() ->
                    TestHtmlHacks.parseSimulateFailure "Event.expectEvent: I found a node, but it does not listen for \"click\" events like I expected it would.\n\n<button>\n    Click Me\n</button>"
                        |> Expect.equal "Event.expectEvent: I found a node, but it does not listen for \"click\" events like I expected it would."
            ]
        ]
