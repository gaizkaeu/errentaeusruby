import { Button, Text, Grid } from '@nextui-org/react'
import { ArrowIcon } from '../components/Icons/ArrowIcon'
import { useNavigate } from 'react-router-dom'
import { Fragment } from 'react'

import Header from '../components/Header'

const HomePage = () => {

  return (
    <Header title="homepage.title" subtitle="homepage.subtitle" gradient="45deg, $yellow600 -20%, $red600 100%"
      subtitle_actions={<HeaderActions/>} />
  )
}

const HeaderActions = () => {
  const navigate = useNavigate()
  return (
    <Fragment>
      <Grid.Container gap={2} justify="center">
        <Button
          rounded
          className="px-6 py-4 mt-8"
          color="gradient"
          size={'lg'}
          auto
          onPress={() => navigate('/calculator')}
          iconRight={<ArrowIcon />}
        >
          Calcula tu precio
        </Button>
      </Grid.Container>
      <Text className="mt-5 text-center">¿Necesitas ayuda?</Text>
    </Fragment>
  )
}

export default HomePage
