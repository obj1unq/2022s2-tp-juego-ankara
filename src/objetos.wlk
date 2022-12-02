import wollok.game.*
import contrarios.*
import interfaz.*

object lionel {

	var property camiseta = "pngVacio.png"
	var property position = game.at(2, 2)
	var property energia = 10
	var property cantidadDePelotas = 5
	var property score = 0
	var puedePatear = false
	const puntosPorPaso = 10
	var recibioAtaque = false
	var recibioConsumible = false

	method image() {
		return camiseta
	}

	method iniciar() {
		camiseta = "lionel-titular.png"
		puedePatear = true
	}

	// Movimiento
	method subir() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != campoDeJuego.height() - 1) {
			position = position.up(1)
		}
	}

	method bajar() {
		// Agrego condicional para no salir del tablero. Cualquier cosa, lo refactorizamos.
		if (position.y() != 0) {
			position = position.down(1)
		}
	}

	method tienePelotas() {
		return cantidadDePelotas > 0
	}

	method aumentarScore() {
		score += puntosPorPaso
		spawner.pasarDeNivelSiCorresponde(score)
	}

	method cambioDeImagenPorAtaque() {
		camiseta = "lionel-golpeado.png"
	}

	method reseteoDeImagen() {
		if (recibioAtaque) {
			recibioAtaque = false
		} else {
			camiseta = "lionel-titular.png"
		}
		if (recibioConsumible) {
			recibioConsumible = false
		} else {
			camiseta = "lionel-titular.png"
		}
	}

	method unTick() {
		if (self.estaMuerto()) {
			self.morir()
		}
		self.aumentarScore()
		self.reseteoDeImagen()
	}

	method patearPelota() {
		if (cantidadDePelotas > 0 and puedePatear) {
			pelotas.agregarNuevo()
			cantidadDePelotas -= 1
			sonidos.sonidoPatearPelota()
			self.esperarAPatear()
		}
	}

	method esperarAPatear() {
		puedePatear = false
		game.schedule(1000, { => puedePatear = true})
	}

	method recibirAtaque(contrario) {
		recibioAtaque = true
		if (contrario.ataque() <= energia) energia -= contrario.ataque() else energia = 0
		sonidos.sonidoDeAtaqueRecibido()
	}

	method colisionarConContrario(contrario) {
		self.cambioDeImagenPorAtaque()
		self.recibirAtaque(contrario)
	}

	method avisoDeMuerte() {
		game.say(self, "Estoy muerto")
	}

	method cambiarAImagenDeMuerte() {
		camiseta = "lionel-muerto.png"
	}


	method morir() {
		self.avisoDeMuerte()
		self.cambiarAImagenDeMuerte()
		sonidos.sonidosDeMuerte()
		puedePatear = false
		gameOver.perder()
	}

	method estaMuerto() {
		return energia <= 0
	}

	method cambiarAImagenDeConsumible() {
		camiseta = "lionel-contento.png"
	}

	method colisionarConConsumible(consumible) {
		game.say(self, "Messirve")
		self.cambiarAImagenDeConsumible()
		recibioConsumible = true
		consumible.serConsumidoPor(self)
	}

	method aumentarEnergia(cantidadDeEnergia) {
		energia += cantidadDeEnergia
		sonidos.sonidoAumentoDeEnergia()
	}

	method aumentarPelotas(nuevacantidadDePelotas) {
		cantidadDePelotas += nuevacantidadDePelotas
		sonidos.sonidoDeRecarga()
	}

	method colisioneCon(objeto) {
	// polimorfismo, metodo de colision de todos los objetos menos messi
	}

}

object pelotas {

	const imagenConPelotas = "pelota.png"
	const imagenSinPelotas = "pngVacio.png"

	// Se debe hacer una imagen transparente para cuando no tenga la pelota
	method image() {
		return if (lionel.tienePelotas()) imagenConPelotas else imagenSinPelotas
	}

	method position() {
		return lionel.position()
	}

	method agregarNuevo() {
		if (lionel.tienePelotas()) {
			const nuevo = new Pelota()
			game.addVisual(nuevo)
			nuevo.serPateada()
		}
	}

	method unTick() {
	// Polimorfismo
	}

	method colisioneCon(objeto) {
	// Polimorfismo
	}

}

class Pelota {

	const property image = "pelota.png"
	var property position = game.at(lionel.position().x() + 1, lionel.position().y())

	method serPateada() {
		game.onTick(conf.velocidad() / 2, self.nombreDeEvento(), { self.moverse()})
	}

	method moverse() {
		game.onCollideDo(self, { o => o.colisioneCon(self)})
		self.asegurarColision()
		position = position.right(1)
		if (position.x() > game.width()) {
			self.removerse()
		}
	}

	method asegurarColision() {
		game.getObjectsIn(position.left(1)).forEach{ o => o.colisioneCon(self)}
	}

	method unTick() {
	}

	method colisioneCon(elemento) {
	// polimorfismo
	}

	method colisionarConConsumible(consumible) {
	// polimorfismo
	}

	method colisionarConContrario(contrario) {
		contrario.serEliminado()
		self.removerse()
	}

	method nombreDeEvento() {
		return "movimiento_pelota" + self.identity()
	}

	method removerse() {
		game.removeVisual(self)
		game.removeTickEvent(self.nombreDeEvento())
	}

}

object conf {

	const property velocidad = 200

}

object campoDeJuego {

	const property height = 5

}

