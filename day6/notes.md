# State Management & Architecture Notes

## 1. BLoC vs. Provider vs. Riverpod

### Comparison Table

| Feature | Provider | BLoC | Riverpod |
|---------|----------|------|----------|
| Core Logic | ChangeNotifier / InheritedWidget | Streams / Events | Providers (Global/Compile-safe) |
| Complexity | Low | High | Medium |
| Dependency | Depends on BuildContext | Depends on BuildContext | Independent of BuildContext |
| Predictability | Medium | Very High (Strict events) | High |
| Best For | Small to Medium apps | Large, complex enterprise apps | Modern apps needing flexibility |

### Decision Matrix

- **Simple state/Small team** → Provider
- **Complex logic/Strict flow/Large team** → BLoC
- **Need for testability/No-context access/Modern DX** → Riverpod

---

## 2. Complex Forms & State

### Multi-step Forms
Use a single state object (Model) that persists across steps. Update the model incrementally; validate the entire model at the final step.

### Optimistic Updates
1. Update the UI immediately
2. Call API in background
3. If API fails, roll back state and show error

### Offline-First
```
UI ↔ Local DB (Hive/Sqflite) ↔ Remote API
```
The UI always reads from the local cache.

---

## 3. State Persistence

### Hydrated BLoC
Extends BLoC to automatically persist and restore state from local storage (JSON).

**Workflow:**
- `fromJson` → Restore state on app start
- `toJson` → Save state on every change

---

## 4. Clean Architecture & Layers

### Layer Separation

- **Presentation Layer:** UI Widgets + State Management (BLoC/Riverpod)
- **Domain Layer:** Entities (Plain objects) + Use Cases (Business rules)
- **Data Layer:** Repositories (Abstracts data source) + Data Sources (API/Local DB)

### Repository Pattern
Acts as a mediator between the Data layer and the Business logic.

**Rule:** State management should call a Repository, never a raw API client.

---

## 5. Testing & Pitfalls

### Testing Strategy

- **Unit Tests:** Test BLoC/Notifier logic (Input Event → Expected State sequence)
- **Mocking:** Use mockito or mocktail to mock Repositories
- **Widget Tests:** Verify UI updates correctly when state changes

### Common Pitfalls

- ❌ **Logic in UI:** Putting if/else business logic inside build methods
- ❌ **God Objects:** Creating one massive state object for the entire app
- ❌ **Leaky Abstractions:** Passing API response models directly to the UI (use Entities instead)
- ❌ **Over-notifying:** Calling `notifyListeners()` or emitting states when data hasn't actually changed

---

## 6. Architecture Documentation

Whenever choosing a pattern, document the Rationale:

- **Problem:** (e.g., "State needed across 5 unrelated screens")
- **Decision:** (e.g., "Used Riverpod StateNotifier")
- **Trade-off:** (e.g., "Increased boilerplate but gained compile-time safety")