import { Text } from '@nextui-org/react'
import {Fragment} from 'react'
import { HeaderMin } from '../components/Header';
const CalculatorComponent = React.lazy(() => import('../components/Calculator/Calculator'));

function CalculatorPage() {
  return (
    <Fragment>
      <HeaderMin title="calculator.title" gradient="45deg, $yellow600 -20%, $red600 100%"/>
      <main className='px-4 mx-auto max-w-7xl sm:px-6 lg:px-8'>
        <CalculatorComponent />
      </main>
    </Fragment>
  )
}

export default CalculatorPage
