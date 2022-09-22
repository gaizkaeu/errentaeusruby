import axios from "axios";
import { CurrentUser, SessionCreationData, UserRegistrationData } from "./authSlice";
import { Estimation, EstimationData } from "./estimationSlice";
import { TaxIncome, TaxIncomeData } from "./taxIncomeSlice";

const API_BASE = "http://192.168.1.129:3000/"

const checkLoggedIn = async () => {
    const response = await axios.get<{user: CurrentUser, logged_in: boolean}>(API_BASE + 'api/v1/logged_in')
    return response.data;
}

const createNewUser = async (data: UserRegistrationData) => {
    const response = await axios.post<CurrentUser>(API_BASE + 'api/v1/users', {api_v1_user: data})
    return response.data;
}

const createNewSession = async (data: SessionCreationData) => {
    const response = await axios.post<CurrentUser>(API_BASE + 'api/v1/users/sign_in', {api_v1_user: data})
    return response.data;
}

const closeSession = async () => {
   const response = await axios.delete(API_BASE + '/api/v1/users/sign_out') 
   return response.status;
}

const createNewEstimation = async (data: EstimationData) => {
    const response = await axios.post<Estimation>(API_BASE + 'api/v1/estimations/estimate', data)
    return response.data;
}

const myEstimation = async () => {
    const response = await axios.get<Estimation>(API_BASE + 'api/v1/estimations/my_estimation')
    return response.data;
}

const createNewTaxIncome = async (data: TaxIncomeData) => {
    const response = await axios.post<TaxIncome>(API_BASE + 'api/v1/tax_incomes/', data)
    return response.data;
}

const listIncomeTaxes = async () => {
    const response = await axios.get<TaxIncome[]>(API_BASE + 'api/v1/tax_incomes/')
    return response.data;
}


export {createNewEstimation, checkLoggedIn, createNewUser, createNewSession, closeSession, myEstimation, createNewTaxIncome, listIncomeTaxes};