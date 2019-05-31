package core
import kotlin.native.concurrent.*

typealias Block = (Any) -> Unit

class Core(var factory: Factory) {
    var listener: Removable? = null
    fun  requestListener() {
        listener = factory.listener(block = {
            println("success: $it")
        })
    }

    fun releaseListener() {
        listener?.remove()
        listener = null
    }
}

interface Factory {
    fun listener(block: Block) : Removable
}

interface Removable {
    fun remove()
}

