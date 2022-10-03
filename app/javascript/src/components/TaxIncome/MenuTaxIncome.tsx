import { useEffect, Fragment} from 'react'
import { Card, Grid, Text } from '@nextui-org/react'
import { NewIcon } from '../Icons/NewIcon'
import { useGetTaxIncomesQuery } from '../../storage/api'
import TaxIncomeResume from './TaxIncomeResume'

const MenuTaxIncome = () => {
  return (
    <Fragment>
      <Text h3>¡Hola!</Text>

      <section className="mt-2">
        <TaxIncomeResume/>
      </section>
    </Fragment>
  )
}

export default MenuTaxIncome
