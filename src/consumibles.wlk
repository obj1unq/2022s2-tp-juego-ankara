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
	const energia = 4

	method energia() {
		return energia
	}

	method avanzar() {
		position = position.left(1)
	}

	method colisioneCon(character) {
		character.recibirEnergia(self)
	}

	method serConsumida() {
		game.removeVisual(self)
		botellas.todos().remove(self)
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
	const cantidad = 5

	method cantidad() {
		return cantidad
	}

	method avanzar() {
		position = position.left(1)
	}

	method colisioneCon(character) {
		character.recargarPelotas(self)
	}

	method serConsumida() {
		game.removeVisual(self)
		bolsas.todos().remove(self)
	}

}

