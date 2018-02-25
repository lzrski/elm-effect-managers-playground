import Elm from "./Main.elm"

program = Elm.Main.embed (document.getElementById "elm")

program.ports.states.subscribe console.log

document
  .getElementById "js"
  .addEventListener "click", () =>
    program.ports.events.send
      kind: "Button Clicked"
      data: null
