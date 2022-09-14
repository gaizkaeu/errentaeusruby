import { Navbar, Button, Text, Switch } from '@nextui-org/react'
import React from 'react'
import { NavLink, useMatch, useResolvedPath } from 'react-router-dom'
import { useDarkMode } from 'usehooks-ts'
import { MoonIcon } from '../Icons/MoonIcon'
import { SunIcon } from '../Icons/SunIcon'

const NavBarLink = ({to, children}: {to: string, children: string}) => {

    const resolvedPath = useResolvedPath(to)
    const isActive = useMatch({ path: resolvedPath.pathname })
  
    return (
      <Navbar.Link isActive={isActive ? true : false} as={NavLink} to={to}>
        {children}
      </Navbar.Link>
    )
}

const Navigation = () => {
  const darkMode = useDarkMode()

  return (
    <Navbar>
      <Navbar.Brand>
        <Text b color="inherit">
          ERRENTA
        </Text>
      </Navbar.Brand>
      <Navbar.Content enableCursorHighlight hideIn="xs" variant="underline">
        <NavBarLink to="/">
          Inicio
        </NavBarLink>
        <NavBarLink to="/calculator">
          Calcular
        </NavBarLink>
      </Navbar.Content>
      <Navbar.Content>
        <div>
          <Switch
            checked={darkMode.isDarkMode}
            onChange={darkMode.toggle}
            size="md"
            iconOn={
              <SunIcon
                filled
                size={undefined}
                height={undefined}
                width={undefined}
                label={undefined}
              />
            }
            iconOff={
              <MoonIcon
                filled
                size={undefined}
                height={undefined}
                width={undefined}
                label={undefined}
              />
            }
          />
        </div>
        <Navbar.Item>
          <Button rounded bordered flat color="warning" size={'md'} auto>
            Eliza Asesores
          </Button>
        </Navbar.Item>
      </Navbar.Content>
    </Navbar>
  )
}

export default Navigation
