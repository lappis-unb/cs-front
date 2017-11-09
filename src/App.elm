module App exposing (main)

import Codeschool.Main as Main

main : Program String Main.Model Main.Msg
main =
    Main.mainWithFlags
