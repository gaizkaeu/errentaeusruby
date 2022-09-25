import { combineReducers, configureStore } from '@reduxjs/toolkit'
import { setupListeners } from '@reduxjs/toolkit/dist/query'
import authSlice from './authSlice'
import calculatorSlice from './calculatorSlice'
import estimationSlice from './estimationSlice'
import { taxIncomeApi } from './taxIncomeApi'
import taxIncomeSlice from './taxIncomeSlice'


export const store = configureStore({
    reducer: {
        estimations: estimationSlice,
        authentication: authSlice,
        calculator: calculatorSlice,
        taxIncomes: taxIncomeSlice,
        [taxIncomeApi.reducerPath]: taxIncomeApi.reducer,
    },
    middleware: (getDefaultMiddleware) =>
        getDefaultMiddleware().concat(taxIncomeApi.middleware),
})

setupListeners(store.dispatch)
// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch