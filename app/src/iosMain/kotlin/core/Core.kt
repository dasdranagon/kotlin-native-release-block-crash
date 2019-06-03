package core
import kotlin.native.concurrent.*

typealias Block = (Any) -> Unit

class Core(val factory: Factory) {
    private var listener: Removable? = null
    fun  requestListener() {
        val block: Block = {
            initRuntimeIfNeeded()
            println("success: $it")
        }
        listener = factory.listener(block = block.freeze())
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
