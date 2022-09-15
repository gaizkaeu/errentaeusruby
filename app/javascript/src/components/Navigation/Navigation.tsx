import {
  Navbar,
  Button,
  Text,
  Switch,
  Dropdown,
  Avatar,
  Link,
} from '@nextui-org/react'
import React from 'react'
import { NavLink, useMatch, useResolvedPath } from 'react-router-dom'
import { useDarkMode } from 'usehooks-ts'
import { useAppSelector } from '../../storage/hooks'
import { MoonIcon } from '../Icons/MoonIcon'
import { SunIcon } from '../Icons/SunIcon'

const NavBarLink = ({ to, children }: { to: string; children: string }) => {
  const resolvedPath = useResolvedPath(to)
  const isActive = useMatch({ path: resolvedPath.pathname })

  return (
    <Navbar.Link isActive={isActive ? true : false} as={NavLink} to={to}>
      {children}
    </Navbar.Link>
  )
}

const NavBarCollapse = ({ to, children }: { to: string; children: string }) => {
  const resolvedPath = useResolvedPath(to)
  const isActive = useMatch({ path: resolvedPath.pathname })

  return (
    <Navbar.CollapseItem
      activeColor="warning"
      isActive={isActive ? true : false}
      as={NavLink}
      to={to}
    >
      {children}
    </Navbar.CollapseItem>
  )
}

const Navigation = () => {
  const darkMode = useDarkMode()
  const loggedIn = useAppSelector((state) => {
    return state.authentication.logged_in
  })

  const collapseItems = [
    ['Inicio', '/'],
    ['Calculadora', '/calculator'],
    ['Mi Estimacion', '/estimation'],
    ['Ayuda', '/help'],
  ]

  return (
    <Navbar>
      <Navbar.Toggle showIn="xs" />
      <Navbar.Brand>
        <Text b color="inherit">
          ERRENTA
        </Text>
      </Navbar.Brand>
      <Navbar.Content enableCursorHighlight hideIn="xs" variant="underline">
        {collapseItems.map((item, index) => (
          <NavBarLink key={index} to={item[1]}>
            {item[0]}
          </NavBarLink>
        ))}
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
        <Navbar.Item hideIn="xs">
          <Button rounded bordered flat  color="warning" size={'md'} auto>
            Eliza Asesores
          </Button>
        </Navbar.Item>
      </Navbar.Content>

      {/* TODO: LOGGED IN DROPDOWNB */}
      {loggedIn && (
        <Navbar.Content
          css={{
            '@xs': {
              w: '12%',
              jc: 'flex-end',
            },
          }}
        >
          <Dropdown placement="bottom-right">
            <Navbar.Item>
              <Dropdown.Trigger>
                <Avatar
                  bordered
                  as="button"
                  color="secondary"
                  size="md"
                  src="https://i.pravatar.cc/150?u=a042581f4e29026704d"
                />
              </Dropdown.Trigger>
            </Navbar.Item>
            <Dropdown.Menu
              aria-label="User menu actions"
              color="secondary"
              onAction={(actionKey) => console.log({ actionKey })}
            >
              <Dropdown.Item key="profile" css={{ height: '$18' }}>
                <Text b color="inherit" css={{ d: 'flex' }}>
                  Signed in as
                </Text>
                <Text b color="inherit" css={{ d: 'flex' }}>
                  zoey@example.com
                </Text>
              </Dropdown.Item>
              <Dropdown.Item key="settings" withDivider>
                My Settings
              </Dropdown.Item>
              <Dropdown.Item key="team_settings">Team Settings</Dropdown.Item>
              <Dropdown.Item key="analytics" withDivider>
                Analytics
              </Dropdown.Item>
              <Dropdown.Item key="system">System</Dropdown.Item>
              <Dropdown.Item key="configurations">Configurations</Dropdown.Item>
              <Dropdown.Item key="help_and_feedback" withDivider>
                Help & Feedback
              </Dropdown.Item>
              <Dropdown.Item key="logout" withDivider color="error">
                Log Out
              </Dropdown.Item>
            </Dropdown.Menu>
          </Dropdown>
        </Navbar.Content>
      )}
      <Navbar.Collapse>
        {collapseItems.map((item, index) => (
          <NavBarCollapse key={index} to={item[1]}>{item[0]}</NavBarCollapse>
        ))}
      </Navbar.Collapse>
    </Navbar>
  )
}

export default Navigation
