import { configureStore } from "@reduxjs/toolkit";
import { setupListeners } from "@reduxjs/toolkit/dist/query";
import authSlice from "./authSlice";
import calculatorSlice from "./calculatorSlice";
import estimationSlice from "./estimationSlice";
import { api } from "./api";

export const store = configureStore({
  reducer: {
    estimations: estimationSlice,
    authentication: authSlice,
    calculator: calculatorSlice,
    [api.reducerPath]: api.reducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat(api.middleware),
});

setupListeners(store.dispatch);
// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>;
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch;
