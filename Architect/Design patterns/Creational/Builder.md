[[Design Patterns]]
[[Creational Design Patterns]]
## def:

the builder is a creational design pattern that lets you construct complex objects step by step.
This design lets you construct different types and representations of an object using the same construction code.

# Principle:

`1`. We define an interface that will contain all the different builders of our intended object, the question is why do we need an interface? well, we might need to implement the builder design pattern in different manners.
`2`. We create the different builders that implement the Builder Interface, each step will be us setting the a field variable of the builder object.
`3`. we create `build` method that will call the constructor of the object we intend to build and pass to it the builder Object.
`4`. we can go further by creating a Director Class:
Having a director class in your program isn’t strictly necessary. You can always call the building steps in a specific order directly from the client code. However, the director class might be a good place to put various construction routines so you can reuse them across your program.
![[Pasted image 20250331074750.png]]


## Advanced tweaks of the builder design pattern

### Inner class builder
to enforce encapsulation we can add the builder class as a static class inside the class of the object to build, making it's constructor private.
example:
```java
class Car {
    private String engine;
    private int wheels;
    private String color;
    private boolean sunroof;
    // Private constructor (forces use of builder)
    private Car(CarBuilder builder) {
        this.engine = builder.engine;
        this.wheels = builder.wheels;
        this.color = builder.color;
        this.sunroof = builder.sunroof;
    }
    @Override
    public String toString() {
        return "Car [Engine=" + engine + ", Wheels=" + wheels + ", Color=" + color + ", Sunroof=" + sunroof + "]";
    }
    // Static Inner Builder Class
    public static class CarBuilder {
        private String engine;
        private int wheels;
        private String color;
        private boolean sunroof;
        public CarBuilder setEngine(String engine) {
            this.engine = engine;
            return this;
        }
        public CarBuilder setWheels(int wheels) {
            this.wheels = wheels;
            return this;
        }
        public CarBuilder setColor(String color) {
            this.color = color;
            return this;
        }
        public CarBuilder setSunroof(boolean sunroof) {
            this.sunroof = sunroof;
            return this;
        }
        public Car build() {
            return new Car(this);
        }
    }
}
// Usage
public class BuilderPatternExample {
    public static void main(String[] args) {
        Car car = new Car.CarBuilder()
                .setEngine("V6")
                .setWheels(4)
                .setColor("Blue")
                .setSunroof(true)
                .build();
                
        System.out.println(car);
    }
}
```
## Using Generics:
If you have multiple types of cars (e.g., **SUV, SportsCar**), generics can help **share common logic** across different builders while keeping type safety.

```java
abstract class CarBuilder<T extends CarBuilder<T>> {
    protected String engine;
    protected int wheels;
    protected String color;
    public T setEngine(String engine) {
        this.engine = engine;
        return self();
    }
    public T setWheels(int wheels) {
        this.wheels = wheels;
        return self();
    }
    public T setColor(String color) {
        this.color = color;
        return self();
    }
    protected abstract T self();  // Ensures method chaining in subclasses
    public abstract Car build();
}
// Concrete Builder for SportsCar
class SportsCarBuilder extends CarBuilder<SportsCarBuilder> {
    private boolean turbo;
    public SportsCarBuilder setTurbo(boolean turbo) {
        this.turbo = turbo;
        return this;
    }
    @Override
    protected SportsCarBuilder self() {
        return this;
    }
    @Override
    public Car build() {
        return new Car(engine, wheels, color, turbo);
    }
}
// Car class with additional field
class Car {
    private String engine;
    private int wheels;
    private String color;
    private boolean turbo;
    public Car(String engine, int wheels, String color, boolean turbo) {
        this.engine = engine;
        this.wheels = wheels;
        this.color = color;
        this.turbo = turbo;
    }
    @Override
    public String toString() {
        return "Car [Engine=" + engine + ", Wheels=" + wheels + ", Color=" + color + ", Turbo=" + turbo + "]";
    }
}

// Usage
public class BuilderPatternExample {
    public static void main(String[] args) {
        Car sportsCar = new SportsCarBuilder()
                .setEngine("V8")
                .setWheels(4)
                .setColor("Red")
                .setTurbo(true)
                .build();
        System.out.println(sportsCar);
    }
}
```