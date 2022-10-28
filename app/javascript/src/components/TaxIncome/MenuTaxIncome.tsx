import { Fragment } from 'react'
import { Button, Text } from '@nextui-org/react'
import TaxIncomeResume from './TaxIncomeResume'
import { useNavigate } from 'react-router-dom'
import { ArrowIcon } from '../Icons/ArrowIcon'
import { useAppSelector } from '../../storage/hooks'
import { ShowMyAssignedTaxIncomes } from './LawyerComponents/AssignedTaxIncomes'

const MenuTaxIncome = () => {
  const nav = useNavigate()
  const account = useAppSelector((state) => state.authentication)
  return (
    <Fragment>
      <div className="flex">
        <div className='flex-1'>
          <Text h3>¡Hola!</Text>
        </div>
        <div>
          <Button
            rounded
            color="success"
            auto
            onPress={() => nav('new')}
            iconRight={<ArrowIcon />}
          >
            Nueva declaración
          </Button>
        </div>
      </div>
      {account.user?.account_type == "user" && (
      <section className="mt-2">
        <TaxIncomeResume />
      </section>
      )}
      {account.user?.account_type == "lawyer" && (
      <section className="mt-2">
        <Text h4> Mis declaraciones asignadas</Text>
        <ShowMyAssignedTaxIncomes />
      </section>
      )}
    </Fragment>
  )
}

export default MenuTaxIncome
