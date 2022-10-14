import {Fragment} from 'react'
import { useAppSelector } from '../storage/hooks'
import { Text } from '@nextui-org/react'
import { HeaderMin } from '../components/Header';
import { Navigate } from 'react-router-dom';

const SingleEstimation = React.lazy(() => import('../components/Estimation/EstimationResume'));
const ContinueEstimation = React.lazy(() => import('../components/Estimation/ContinueEstimation'));

function EstimationPage() {
  const estimations = useAppSelector((state) => state.estimations.estimation)

  return (
    <Fragment>
      <HeaderMin gradient="45deg, $blue600 -20%, $pink600 50%" title="estimation.title" subtitle="estimation.subtitle"/>
      <main className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        {estimations ? (
          <div className="grid items-center grid-cols-1 lg:grid-cols-2 gap-10 p-3 self-center">
            <SingleEstimation
              estimation={estimations}
            />
            <ContinueEstimation/> 
          </div>
        ) : (
          <Navigate to="/calculator" replace></Navigate>
        )}
      </main>
    </Fragment>
  )
}

export default EstimationPage
