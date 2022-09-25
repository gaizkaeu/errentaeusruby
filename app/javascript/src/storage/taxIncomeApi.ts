import {BaseQueryFn, buildCreateApi, createApi, fetchBaseQuery} from '@reduxjs/toolkit/query/react'
import axios, { AxiosError, AxiosRequestConfig } from 'axios'
import { Estimation } from './estimationSlice'

interface TaxIncome {
  price: number,
  id: number,
  state: TaxIncomeStatus,
  estimation?: Estimation,
  lawyer_id: number,
  appointment_id: number,
  created_at: Date
}

type TaxIncomeStatus = "pending_assignation" | "waiting_for_meeting_creation" |"waiting_for_meeting" | "rejected" | "pending_documentation" | "in_progress" | "finished"



interface TaxIncomeData {
    load_price_from_estimation: boolean,
    observations: string,
  }

type TaxIncomesResponse = TaxIncome[]

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
  tagTypes: ['TaxIncome'],
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
        query: (data) => ({url: `tax_incomes`, method: 'post', body: data}),
        invalidatesTags: [{ type: 'TaxIncome', id: 'LIST' }],
      }),
  }),
})

export const { useGetTaxIncomesQuery, useGetTaxIncomeByIdQuery, useCreateTaxIncomeMutation } = taxIncomeApi