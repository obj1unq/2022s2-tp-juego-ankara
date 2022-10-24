import wollok.game.*

object contrarios {

	const property todos = #{}

	method agregarNuevo() {
		const nuevo = new Contrario()
		game.addVisual(nuevo)
		todos.add(nuevo)
	}

	method avanzarTodos() {
		todos.forEach({ contrario => contrario.avanzar()})
	}

}

class Contrario {

	var property image = "aleman.png"
	var property position = game.at((0 .. 4).anyOne(), 19)

	method avanzar() {
		position = position.down(1)
	}

}

