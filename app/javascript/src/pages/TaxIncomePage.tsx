import {Fragment} from 'react'
import { Text } from '@nextui-org/react'
import { Outlet } from 'react-router-dom'
import { HeaderMin } from '../components/Header'

function TaxIncomePage() {

  return (
    <Fragment>
      <HeaderMin title="taxincome.title" gradient="45deg, $blue600 -20%, $pink600 50%" textClass='text-4xl font-bold text-black sm:text-5xl xl:text-6xl'/>
      <main className="max-w-7xl px-4 mx-auto sm:px-6 lg:px-8">
        <Outlet/>
      </main>
    </Fragment>
  )
}

export default TaxIncomePage
