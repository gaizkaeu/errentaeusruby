import {Fragment, useEffect} from 'react'
import { Loading, Spacer, Text } from '@nextui-org/react';
import { useNavigate, useParams } from 'react-router-dom'
import TaxIncomeCard from './components/TaxIncomeCard';
import AssignedLawyerCard from '../Lawyer/AssignedLawyer';
import { useGetTaxIncomeByIdQuery } from '../../storage/api';
import EstimationWrapper from '../Estimation/card/Estimation';

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

  return (
    <Fragment>
      <div className="items-center flex flex-wrap gap-10 p-3 self-center place-content-center">
        {!isLoading && currentData? (
          <Fragment>
            <div className="flex-1">
              <TaxIncomeCard taxIncome={currentData!} renderCard={page}></TaxIncomeCard>
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
