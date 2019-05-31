# MPP Project aims to reproduce a "Block release" crash. 

We were facing an issue using Firebase in MPP project. 

~~~swift
func listener(block: @escaping (Any) -> KotlinUnit) -> Removable {
    let to = TestObject(mark: "listenet T.O.")
    return NoARCListener { _ in
        debugPrint("\(to)")
        _ = block(to)
    }
}
~~~

~~~swift
class FirebaseFactory: Factory {
    typealias SuccessHandler = (Any) -> KotlinUnit

    let db = Firestore.firestore()

    func listener(block: @escaping (Any) -> KotlinUnit) -> Removable {
        return FirebaseListener(db: db, success: block)
    }
}

class FirebaseListener: Removable {
    var listener: ListenerRegistration?
    init(db: Firestore, success: @escaping (Any) -> KotlinUnit) {
        listener = db.collection("users").addSnapshotListener { snapshot, error in
            if let snapshot = snapshot {
                _ = success(snapshot.documents)
            }

            if let error = error {
                debugPrint("error: \(error)")
            }
        }
    }

    func remove() {
        listener?.remove()
    }
}
~~~

~~~objective-c
@implementation NoARCListener

- (instancetype)initWithBlock:(ListenerBlock)block {
    if (self = [super init]) {
        _listenerBlock = [block retain];
    }

    return self;
}

- (void)remove {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        [_listenerBlock release];
    });
}
~~~

~~~cotlin
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
~~~

![Firebase crash](firebase-crash-stacktrace.png)


![Non ARC library crash](custom-impl-stacktrace.png)
