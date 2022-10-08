import {Fragment} from 'react'
import { Text } from '@nextui-org/react'
import { Outlet } from 'react-router-dom'
import { HeaderMin } from '../components/Header'

function TaxIncomePage() {

  return (
    <Fragment>
      <HeaderMin title="taxincome.title" gradient="45deg, $blue600 -20%, $pink600 50%"></HeaderMin>
      <main className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <Outlet/>
      </main>
    </Fragment>
  )
}

export default TaxIncomePage
