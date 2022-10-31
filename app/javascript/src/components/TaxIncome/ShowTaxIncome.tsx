import {Fragment, useEffect} from 'react'
import { Loading, Spacer, Text } from '@nextui-org/react';
import { Navigate, useNavigate, useParams } from 'react-router-dom'
import TaxIncomeCard from './components/TaxIncomeCard';
import AssignedLawyerCard from '../Lawyer/AssignedLawyer';
import { useGetTaxIncomeByIdQuery } from '../../storage/api';
import EstimationWrapper from '../Estimation/card/Estimation';

const Stepper = () => {
  return (
    <div className="mx-2 p-2">
        <div className="flex items-center">
            <div className="flex items-center text-teal-600 relative">
                <div className="rounded-full transition duration-500 ease-in-out h-12 w-12 py-3 border-2 border-teal-600">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" className="feather feather-bookmark ">
                        <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path>
                    </svg>
                </div>
                <div className="absolute top-0 -ml-10 text-center mt-16 w-32 text-xs font-medium uppercase text-teal-600"><Text hideIn="xs">Cita</Text></div>
            </div>
            <div className="flex-auto border-t-2 transition duration-500 ease-in-out border-teal-600"></div>
            <div className="flex items-center text-white relative">
                <div className="rounded-full transition duration-500 ease-in-out h-12 w-12 py-3 border-2 bg-teal-600 border-teal-600">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" className="feather feather-user-plus ">
                      <path xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" clip-rule="evenodd" d="M14.1213 11.2331H16.8891C17.3088 11.2331 17.6386 10.8861 17.6386 10.4677C17.6386 10.0391 17.3088 9.70236 16.8891 9.70236H14.1213C13.7016 9.70236 13.3719 10.0391 13.3719 10.4677C13.3719 10.8861 13.7016 11.2331 14.1213 11.2331ZM20.1766 5.92749C20.7861 5.92749 21.1858 6.1418 21.5855 6.61123C21.9852 7.08067 22.0551 7.7542 21.9652 8.36549L21.0159 15.06C20.8361 16.3469 19.7569 17.2949 18.4879 17.2949H7.58639C6.25742 17.2949 5.15828 16.255 5.04837 14.908L4.12908 3.7834L2.62026 3.51807C2.22057 3.44664 1.94079 3.04864 2.01073 2.64043C2.08068 2.22305 2.47038 1.94649 2.88006 2.00874L5.2632 2.3751C5.60293 2.43735 5.85274 2.72207 5.88272 3.06905L6.07257 5.35499C6.10254 5.68257 6.36234 5.92749 6.68209 5.92749H20.1766ZM7.42631 18.9079C6.58697 18.9079 5.9075 19.6018 5.9075 20.459C5.9075 21.3061 6.58697 22 7.42631 22C8.25567 22 8.93514 21.3061 8.93514 20.459C8.93514 19.6018 8.25567 18.9079 7.42631 18.9079ZM18.6676 18.9079C17.8282 18.9079 17.1487 19.6018 17.1487 20.459C17.1487 21.3061 17.8282 22 18.6676 22C19.4969 22 20.1764 21.3061 20.1764 20.459C20.1764 19.6018 19.4969 18.9079 18.6676 18.9079Z"/>
                    </svg>
                </div>
                <div className="absolute top-0 -ml-10 text-center mt-16 w-32 text-xs font-medium uppercase text-teal-600"><Text hideIn="xs">Pago</Text></div>
            </div>
            <div className="flex-auto border-t-2 transition duration-500 ease-in-out border-gray-300"></div>
            <div className="flex items-center text-teal-600 relative">
                <div className="rounded-full transition duration-500 ease-in-out h-12 w-12 py-3 border-2 border-gray-300">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" className="feather feather-mail ">
                        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                        <polyline points="22,6 12,13 2,6"></polyline>
                    </svg>
                </div>
                <div className="absolute top-0 -ml-10 text-center mt-16 w-32 text-xs font-medium uppercase text-gray-500"><Text hideIn="xs">Datos</Text></div>
            </div>
            <div className="flex-auto border-t-2 transition duration-500 ease-in-out border-gray-300"></div>
            <div className="flex items-center text-teal-600 relative">
                <div className="rounded-full transition duration-500 ease-in-out h-12 w-12 py-3 border-2 border-gray-300">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" className="feather feather-database ">
                        <ellipse cx="12" cy="5" rx="9" ry="3"></ellipse>
                        <path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"></path>
                        <path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"></path>
                    </svg>
                </div>
                <div className="absolute top-0 -ml-10 text-center mt-16 w-32 text-xs font-medium uppercase text-gray-500"><Text hideIn="xs">Finalizado</Text></div>
            </div>
        </div>
    </div>
  )
}

const ShowTaxIncome = () => {
  const { tax_income_id, page} = useParams()
  const {currentData, isError, isLoading} = useGetTaxIncomeByIdQuery(tax_income_id!, {
    pollingInterval: 10000
  });
  const nav = useNavigate()

  useEffect(() => {
    if (!page && currentData) {
      nav(`/mytaxincome/${tax_income_id}/${currentData?.state}`, {replace: true})
    }
  })

  const navCurrentState = () => <Navigate to={`/mytaxincome/${tax_income_id}/${currentData?.state}`} replace={true}></Navigate>

  return (
    <Fragment>
      <Stepper/>
      <div className="flex flex-wrap gap-10 p-3 md:mt-10">
        {!isLoading && currentData? (
          <Fragment>
            <div className="flex-1">
              <TaxIncomeCard taxIncome={currentData!} renderCard={page} navCurrentState={navCurrentState()}></TaxIncomeCard>
            </div>
            <div className="w-full lg:w-auto">
              {currentData.lawyer && <AssignedLawyerCard lawyerId={currentData.lawyer} /> }
              <Spacer/>
              <EstimationWrapper estimationId={currentData.estimation}/>
            </div>
          </Fragment>
        ) : (
          <Loading/>
        )}
      </div>

    </Fragment>
  )
}

export default ShowTaxIncome
