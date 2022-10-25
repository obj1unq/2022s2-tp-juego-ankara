import wollok.game.*

object lionel {
	var property camiseta = "lionel-titular.png"
	var property position = game.at(2, 2)

	method image() {
		return camiseta
	}
	
	method subir() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
    	if (position.y() != game.height() - 1){
    		position = position.up(1)
    	}   	 
    }
	
	method bajar(){
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != 0){
			position = position.down(1)
		}	
	}
	
	method patear() {
	}

}

object pelota {
	const property image = "pelota.png"
	var property position = game.at(5, 5)
}
	
	

