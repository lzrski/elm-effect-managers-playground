import Elm from "./Main.elm"

program = Elm.Main.fullscreen()

program.ports.states.subscribe console.log
