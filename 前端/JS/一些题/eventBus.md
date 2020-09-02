# eventBus
```javascript
class EventEmitter {
    constructor() {
        this.events = {}
    }
    emit(eventName, ...args) {
        for (let fn of this.events[eventName]) {
            fn.apply(null, args)
        }
    }
    on(eventName, fn) {
        if (!this.events[eventName]) {
            this.events[eventName] = [];
        }
        this.events[eventName].push(fn);
    }
    off(eventName, fn) {
        let fnList = this.events[eventName]
        for (let index in fnList) {
            if (fnList[index] === fn) {
                fnList.splice(index, 1)
            }
        }
    }
}

let event = new EventEmitter
function a(a) {
    console.log(a)
}
function b() {
    console.log('b')
}
event.on('a', a)
event.emit('a', '123')
event.off('a', a)
console.log(event)
```