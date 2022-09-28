import {BaseQueryFn, buildCreateApi, createApi, fetchBaseQuery} from '@reduxjs/toolkit/query/react'
import axios, { AxiosError, AxiosRequestConfig } from 'axios'
import { TaxIncomesResponse, Appointment, TaxIncome, TaxIncomeData, Estimation, IUser } from './types'

const axiosBaseQuery =
  (
    { baseUrl }: { baseUrl: string } = { baseUrl: '' }
  ): BaseQueryFn<
    {
      url: string
      method: AxiosRequestConfig['method']
      data?: AxiosRequestConfig['data']
      params?: AxiosRequestConfig['params']
    },
    unknown,
    unknown
  > =>
  async ({ url, method, data, params }) => {
    try {
      const result = await axios({ url: baseUrl + url, method, data, params })
      return { data: result.data }
    } catch (axiosError) {
      let err = axiosError as AxiosError
      return {
        error: {
          status: err.response?.status,
          data: err.response?.data || err.message,
        },
      }
    }
  }

export const taxIncomeApi = createApi({
  reducerPath: 'taxIncomeApi',
  baseQuery: axiosBaseQuery({baseUrl: '/api/v1/'}),
  tagTypes: ['TaxIncome', 'Appointment', 'Estimation', 'Lawyer'],
  endpoints: (build) => ({
    getTaxIncomes: build.query<TaxIncomesResponse, void>({
      query: () => ({url: 'tax_incomes', method: 'get'}),
      providesTags: (result) =>
        result
          ? [
              ...result.map(({ id }) => ({ type: 'TaxIncome' as const, id })),
              { type: 'TaxIncome', id: 'LIST' },
            ]
          : [{ type: 'TaxIncome', id: 'LIST' }],
    }),
    getTaxIncomeById: build.query<TaxIncome, string>({
        query: (id) => ({url: `tax_incomes/${id}`, method: 'get'}),
        providesTags: (result, error, id) => [{type: 'TaxIncome', id}],
      }),
    createTaxIncome: build.mutation<TaxIncome, TaxIncomeData>({
        query: (data) => ({url: `tax_incomes`, method: 'post', data: data}),
        invalidatesTags: [{ type: 'TaxIncome', id: 'LIST' }],
      }),
    getAppointments: build.query<Appointment[], void>({
      query: () => ({url: 'appointments', method: 'get'}),
      providesTags: (result) =>
        result
          ? [
              ...result.map(({ id }) => ({ type: 'Appointment' as const, id })),
              { type: 'Appointment', id: 'LIST' },
            ]
          : [{ type: 'Appointment', id: 'LIST' }],
    }),
    createAppointmentToTaxIncome: build.mutation<Appointment, Partial<Appointment>>({
      query: (data) => ({url: 'appointments', method: 'post', data: data}),
      invalidatesTags: (result) => [{ type: 'TaxIncome', id:  result?.tax_income_id}, {type: 'Appointment', id: 'LIST'}],
    }), 
    getAppointmentById: build.query<Appointment, string>({
      query: (id) => ({url: `appointments/${id}`, method: 'get'}),
      providesTags: (result, error, id) => [{type: 'Appointment', id}],
    }),
    getEstimationById: build.query<Estimation, string>({
      query: (id) => ({url: `estimations/${id}`, method: 'get'}),
      providesTags: (result, error, id) => [{type: 'Estimation', id}],
    }),
    getLawyerById: build.query<IUser, string>({
      query: (id) => ({url: `lawyers/${id}`, method: 'get'}),
      providesTags: (result, error, id) => [{type: 'Lawyer', id}],
    }),
    updateAppointmentById: build.mutation<Appointment, Partial<Appointment>>({
      query: (data) => ({url: `appointments/${data.id}`, method: 'put', body: data}),
      invalidatesTags: (result, error) => [{ type: 'TaxIncome', id:  result?.tax_income_id}, {type: 'Appointment', id: result?.id}],
    }),
  }),
})

export const { useGetTaxIncomesQuery, useGetTaxIncomeByIdQuery, useCreateTaxIncomeMutation, useCreateAppointmentToTaxIncomeMutation,
               useGetAppointmentByIdQuery, useGetEstimationByIdQuery, useGetLawyerByIdQuery, useGetAppointmentsQuery } = taxIncomeApi