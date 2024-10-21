
# About Sealed Classes and Pattern Matching

## Why Sealed Classes?

- **Exhaustive switch Statements:** Ensures that all possible cases are handled, improving code reliability.

- **Enhanced Type Safety:** Restricts unexpected subclasses from being introduced, ensuring that only predefined subclasses are used.

- **Clear Intent:** Makes the codebase easier to understand and maintain by clearly defining the possible states.

## Use Cases in Regular Development

### State Management:
- Sealed classes are effective for representing different states of a feature, such as the stages in a login process:

```dart
sealed  class  LoginState {}

class  LoginInitial  extends  LoginState {}

class  LoginLoading  extends  LoginState {}

class  LoginSuccess  extends  LoginState {}

class  LoginError  extends  LoginState {

final  String message;

LoginError(this.message);

}
```

### Error Handling

- Sealed classes can define a set of possible errors, ensuring type safety in error handling:

```dart
sealed  class  NetworkError {}

class  TimeoutError  extends  NetworkError {}

class  ServerError  extends  NetworkError {

final  int code;

ServerError(this.code);

}

class  UnknownError  extends  NetworkError {}
```

  

### Navigation Events

- Sealed classes can represent different navigation actions within the app, making it easier to manage routing.

## Why Pattern Matching?

- **More Readable Code:** Offers a cleaner and more intuitive control flow compared to traditional conditional structures.

- **Less Boilerplate:** Reduces the need for repetitive if-else or switch-case statements.

- **Compile-Time Safety:**  Ensures all possible cases are handled, reducing runtime errors.

```dart
void  handleLoginState(LoginState state) {
	switch (state) {
	
	case  LoginInitial():
	print('Initial State');
	
	case  LoginLoading():
	print('Loading...');
	
	case  LoginSuccess():
	print('Login Successful');

	case  LoginError(message: var msg):
	print('Error: $msg');

	}
}
```

  
## Why Sealed Classes Are Better Than Enums?

- **Rich Data Representation:** While enums are limited to constant values, sealed classes can hold data, offering more flexibility.

```dart
enum  ConnectionState { disconnected, connecting, connected }
```

vs.

```dart

sealed  class  ConnectionState {}

class  Disconnected  extends  ConnectionState {}

class  Connecting  extends  ConnectionState {}

class  Connected  extends  ConnectionState {

final  String connectionId;

Connected(this.connectionId);

}

```

- **Extensibility:** Sealed classes can have multiple subclasses with different properties, enabling more complex state representations.

- **Type Safety:** Sealed classes ensure exhaustive checking with pattern matching, preventing unhandled cases.

- **Behavior Encapsulation:** Sealed classes can encapsulate methods and behaviors, while enums cannot.

## cart service demo with enum and sealed class including pattern matching.

- Please find detailed demo inside sealed_class_and_desructuring directory

## Benefits Highlighted in the Demo

**1. Exhaustive Handling:**

The switch statements cover all possible subclasses of CheckoutState and CheckoutFailure, ensuring that no case is left unhandled.

**2. Enhanced Type Safety:**

The compiler enforces that all possible states and failures are considered, reducing the likelihood of runtime errors.

**3. Rich Data Representation:**

Each state and failure can carry associated data, such as ShippingInfo, PaymentInfo, or error reasons, providing more context and flexibility.

**4. Behavior Encapsulation:**

Methods like _validateShipping, _processPayment, and _verifyMFA encapsulate state-specific logic, promoting the Single Responsibility Principle and keeping the code modular.

**5. Extensibility:**

New states (e.g., MFARequired) or new failure types (e.g., OutOfStock) can be added without altering existing logic, adhering to the Open/Closed Principle.

**6. Readable and Maintainable Code:**

Pattern matching provides a clear and concise way to handle different states, making the codebase easier to navigate, read, and maintain.