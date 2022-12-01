import wollok.game.*
import objetos.*
import contrarios.*
import consumibles.*

const musicaMenu = game.sound("musicaMenu.mp3")

class Visor {

	const alturaDeVisores = game.height() - 0.5

	method position()

	method textColor() {
		return "000000"
	}

	method unTick() {
	}

}

object visorEnergia inherits Visor {

	override method position() {
		return game.at(1, alturaDeVisores)
	}

	method text() {
		return "Energía: " + lionel.energia()
	}

}

object visorPelotas inherits Visor {

	override method position() {
		return game.at(game.width() - 3, alturaDeVisores - 0.5)
	}

	method image() {
		return "contador-pelota.png"
	}

	method text() {
		return "" + lionel.cantidadDePelotas()
	}

}

object visorScore inherits Visor {

	override method position() {
		return game.at(5, alturaDeVisores)
	}

	method text() {
		return "Score: " + lionel.score()
	}

	method colisioneCon(objeto) {
	}

}

object visorNivel inherits Visor {

	override method position() {
		return game.at(game.width() - 1.5, alturaDeVisores)
	}

	method image() {
		return spawner.nivel().imagenBanderas()
	}

	method colisioneCon(objeto) {
	}

}

object spawner {

	var property nivel = nivel0
	var contrariosAgregadosPorConsumible = 0
	//
	const posicionInicialDeX = 19
	var ultimoPosicionDeY = null
	const posicionesDeYDelJuego = [ 0, 1, 2, 3, 4 ]

	method posicionesDeYPosibles() {
		return posicionesDeYDelJuego.copyWithout(ultimoPosicionDeY)
	}

	method position() {
		return game.origin()
	}

	method posicionRandomDeY() {
		return self.posicionesDeYPosibles().anyOne()
	}

	method newPosition() {
		return game.at(posicionInicialDeX, self.posicionRandomDeY())
	}

	method pasarDeNivelSiCorresponde(score) {
		nivel = nivel.nivelSegunScore(score)
	}

	method agregarConsumible(posicion) {
		nivel.consumibles().anyOne().agregarNuevo(posicion)
	}

	method agregarContrario(posicion) {
		nivel.contrarios().anyOne().agregarNuevo(posicion)
	}

	method unTick() {
		nivel.unTick()
		if (nivel.correspondeCrear()) {
			self.crearContrarioOConsumibleEn(self.newPosition())
		}
	}

	method crearContrarioOConsumibleEn(posicion) {
		if (contrariosAgregadosPorConsumible < nivel.cantidadDeContrariosPorConsumible()) {
			self.agregarContrario(posicion)
			contrariosAgregadosPorConsumible++
		} else {
			self.agregarConsumible(posicion)
			contrariosAgregadosPorConsumible = 0
		}
		self.guardarUltimaPosicionDeY(posicion)
	}

	method guardarUltimaPosicionDeY(posicion) {
		ultimoPosicionDeY = posicion.y()
	}

}

class Nivel {

	method nombre()

	method imagenBanderas()

	method contrarios() {
		return [ alemanes ]
	}

	method consumibles() {
		return [ bolsasDePelotas, gatorades ]
	}

	method cantidadDeContrariosPorConsumible() {
		return 5
	}

	method correspondeCrear() {
		return true
	}

	method nivelSegunScore(score)

	method unTick() {
	}

}

object nivel0 inherits Nivel {

	var ticksGuardados = 3
	const ticksParaCrearAlgo = 3

	override method nombre() {
		return "1 - Alemania"
	}

	override method imagenBanderas() {
		return "nivel1.png"
	}

	override method unTick() {
		if (ticksGuardados < ticksParaCrearAlgo) {
			ticksGuardados += 1
		} else {
			ticksGuardados = 1
		}
	}

	override method correspondeCrear() {
		return ticksGuardados == ticksParaCrearAlgo
	}

	override method nivelSegunScore(score) {
		return if (score < 200) self else nivel1
	}

}

object nivel1 inherits Nivel {

	override method imagenBanderas() {
		return "nivel1.png"
	}

	override method nombre() {
		return "1 - Alemania"
	}

	override method nivelSegunScore(score) {
		return if (score < 1000) self else nivel2
	}

}

object nivel2 inherits Nivel {

	override method imagenBanderas() {
		return "nivel2.png"
	}

	override method nombre() {
		return "2 - Alemania y Brasil"
	}

	override method contrarios() {
		return super() + [ brasileros ]
	}

	override method nivelSegunScore(score) {
		return if (score < 2000) self else nivel3
	}

}

object nivel3 inherits Nivel {

	override method imagenBanderas() {
		return "nivel3.png"
	}

	override method nombre() {
		return "3 - Alemania, Brasil e Inglaterra"
	}

	override method contrarios() {
		return nivel2.contrarios() + [ ingleses ]
	}

	override method nivelSegunScore(score) {
		return if (score < 3000) self else nivel4
	}

}

object nivel4 inherits Nivel {

	override method imagenBanderas() {
		return "nivel3.png"
	}

	override method nombre() {
		return "3 - Alemania, Brasil e Inglaterra"
	}

	override method contrarios() {
		return nivel3.contrarios()
	}

	override method cantidadDeContrariosPorConsumible() {
		return 10
	}

	override method nivelSegunScore(score) {
		return self
	}

}

object sonidos {

	method sonidoDeAtaqueRecibido() {
		game.sound("nearmiss.mp3").play()
	}

	method sonidosDeMuerte() {
		game.sound("silbato.mp3").play()
		game.sound("no.mp3").play()
		game.sound("hinchada1.mp3").play()
	}

	method sonidoPatearPelota() {
		game.sound("patada.mp3").play()
	}

	method sonidoDeRecarga() {
		game.sound("recarga.mp3").play()
	}

	method sonidoAumentoDeEnergia() {
		game.sound("energia.mp3").play()
	}

}

object menuPrincipal {
	const volumen = 0.1
	var musicaActiva = false
	var property juegoComenzado = false
	var imagen = "menuPrincipal.png"
	
	method position(){return game.origin()}
	
	method image(){ return imagen }
	
	method comenzar(){
		imagen = "pngVacio.png"
		self.inicializarJuego()
	}
	
	method inicializarJuego(){
		if(not juegoComenzado){
			lionel.iniciar()
			self.inicializarValores()
			game.addVisual(pelotas)
			game.addVisual(visorEnergia)
			game.addVisual(visorPelotas)
			game.addVisual(visorScore)
			game.addVisual(visorNivel)
			game.addVisual(spawner)
			juegoComenzado = true
		}
	}
	
	method inicializarValores(){
		lionel.score(0)
		//lionel.cantidadDePelotas(10)
		spawner.nivel(nivel0)
	}
	
	method unTick(){
		//polimorfismo
		self.activarMusica()
	}
	
	method activarMusica(){
		if(not musicaActiva){
			musicaMenu.volume(volumen)
			musicaMenu.play()
			musicaActiva = true
		}
	}
}

object gameOver{
	method position(){return game.origin()}
	method image(){return "gameOver.png"}
	
	method perder(){
		programa.estado(finalizado)
		game.addVisualIn(puntajeFinal, game.at(10,0))
		game.addVisualIn(mensajeReplay, game.at(10,game.height() - 1))
		musicaMenu.stop()
	}
	
	method volverAJugar(){
		menuPrincipal.juegoComenzado(false)
		game.allVisuals().forEach({visual => game.removeVisual(visual)})
		//restauro visuales
		game.addVisual(lionel)
		menuPrincipal.comenzar()
		lionel.energia(10)
		lionel.cantidadDePelotas(10)
		programa.estado(corriendo)
	}
	
	method unTick(){
		//polimorfismo
	}
}

object puntajeFinal{
	method text(){return "Mejor Puntaje: " + lionel.maximoScore()}
	method textColor() {return "FF0000"}
	
	method unTick(){
		//polimorfismo
	}
}

object mensajeReplay{
	method text(){return "Apreta enter para volver a jugar "}
	method textColor() {return "FF0000"}
	
	method unTick(){
		//polimorfismo
	}
}

object programa{
	var property estado = inicio
	
	method onTick(){
		estado.onTick()
	}
	
	method iniciar(){
		estado.iniciar()
	}
}

object inicio{
	method iniciar(){
		menuPrincipal.comenzar()
		programa.estado(corriendo)
	}
	
	method onTick(){
	
	}
}

object corriendo{
	method iniciar(){

	}
	
	method onTick(){
		game.allVisuals().forEach{ visual => visual.unTick()}
	}
}

object finalizado{
	method iniciar(){
		gameOver.volverAJugar()
	}
	
	method onTick(){
		
	}
}
