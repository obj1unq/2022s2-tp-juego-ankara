import wollok.game.*

object lionel {
	var property camiseta = "lionel-titular.png"
	var property position = game.at(1, 2)

	method image() {
		return camiseta
	}

	method patear() {
	}

}

object pelota {

	const property image = "pelota.png"
	var property position = game.at(5, 5)
}

