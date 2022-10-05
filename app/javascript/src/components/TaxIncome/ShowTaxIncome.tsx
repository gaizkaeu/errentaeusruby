import {Fragment} from 'react'
import { Spacer, Text } from '@nextui-org/react';
import { useParams } from 'react-router-dom'
import TaxIncomeCard from './components/TaxIncomeCard';
import AssignedLawyerCard from '../Lawyer/AssignedLawyer';
import { useGetTaxIncomeByIdQuery } from '../../storage/api';
import EstimationWrapper from '../Estimation/Estimation';

const ShowTaxIncome = () => {
  const { tax_income_id } = useParams()
  const {currentData, isError, isLoading} = useGetTaxIncomeByIdQuery(tax_income_id!);

  return (
    <Fragment>
      <div className="items-center flex flex-wrap gap-10 p-3 self-center place-content-center">
        {!isError && !isLoading && currentData? (
          <Fragment>
            <div className="flex-1">
              <TaxIncomeCard taxIncome={currentData!}></TaxIncomeCard>
            </div>
            <div className="w-full lg:w-auto">
              {currentData.lawyer && <AssignedLawyerCard lawyerId={currentData.lawyer} /> }
              <Spacer/>
              <EstimationWrapper estimationId={currentData.estimation}/>
            </div>
          </Fragment>
        ) : (
          <Text>Cargando... o no tienes permisos</Text>
        )}
      </div>

    </Fragment>
  )
}

export default ShowTaxIncome
