import wollok.game.*

object botellas {

	const property todos = #{}

	method agregarNuevo() {
		const nuevo = new Botella()
		game.addVisual(nuevo)
		todos.add(nuevo)
	}

	method avanzarTodos() {
		todos.forEach({ botella => botella.avanzar()})
	}

}

class Botella {

	var property image = "gatorade.png"
	var property position = game.at(19, (0 .. 4).anyOne())

	method avanzar() {
		position = position.left(1)
	}

}

object bolsas {

	const property todos = #{}

	method agregarNuevo() {
		const nuevo = new Bolsa()
		game.addVisual(nuevo)
		todos.add(nuevo)
	}

	method avanzarTodos() {
		todos.forEach({ bolsa => bolsa.avanzar()})
	}

}

class Bolsa {

	var property image = "bolsaPelotas.jpg"
	var property position = game.at(19, (0 .. 4).anyOne())

	method avanzar() {
		position = position.left(1)
	}

}
