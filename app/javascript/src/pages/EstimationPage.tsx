import { Button, Text } from '@nextui-org/react'
import React from 'react'
import { useNavigate } from 'react-router-dom'
import SingleEstimation from '../components/Estimation/Estimation'
import { ArrowIcon } from '../components/Icons/ArrowIcon'
import { firstStep } from '../storage/calculatorSlice'
import { useAppDispatch, useAppSelector } from '../storage/hooks'

function EstimationPage() {
  const estimations = useAppSelector((state) => state.estimations)
  const dispatch = useAppDispatch()
  const nav = useNavigate()

  return (
    <header>
      <section className="py-5 ">
        <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
          <div>
            <Text className="text-base font-semibold tracking-wider">
              UN SERVICIO DE ELIZA ASESORES
            </Text>
            <Text
              className="text-5xl font-bold text-black sm:text-7xl  xl:text-8xl"
              css={{
                textGradient: '45deg, $blue600 -20%, $pink600 50%',
              }}
            >
              Estimación
            </Text>
            <Text h4>
              Gracias por llegar hasta aquí. Esta información es solo visible
              para ti.
            </Text>
          </div>
          {estimations.price !== -1.0 ? (
            <div className="mt-12">
              <div className="grid items-center grid-cols-1 lg:grid-cols-2 gap-4 p-3 self-center">
                <SingleEstimation
                  estimation={estimations}
                  req={estimations.estimation_props!}
                />
                <div className="flex flex-wrap place-items-center gap-4 justify-items-center">
                  <Button
                    rounded
                    bordered
                    flat
                    className="px-6 py-4 "
                    color="warning"
                    size={'lg'}
                    auto
                    iconRight={<ArrowIcon />}
                  >
                    ¿Continuamos?
                  </Button>
                  <Button
                    rounded
                    bordered
                    flat
                    className="px-6 py-4 "
                    color="error"
                    size={'lg'}
                    onPress={() => {
                      dispatch(firstStep())
                      nav('/calculator')
                    }}
                    auto
                  >
                    Quiero revisar mis respuestas.
                  </Button>
                </div>
              </div>
            </div>
          ) : (
            <Text>No hay na</Text>
          )}
        </div>
      </section>
    </header>
  )
}

export default EstimationPage
