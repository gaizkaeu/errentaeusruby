import { Fragment } from 'react'
import { Button, Text } from '@nextui-org/react'
import TaxIncomeResume from './TaxIncomeResume'
import { useNavigate } from 'react-router-dom'
import { ArrowIcon } from '../Icons/ArrowIcon'

const MenuTaxIncome = () => {
  const nav = useNavigate()
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
      <section className="mt-2">
        <TaxIncomeResume />
      </section>
    </Fragment>
  )
}

export default MenuTaxIncome
