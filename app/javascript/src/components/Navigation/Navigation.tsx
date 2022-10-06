import {
  Navbar,
  Button,
  Text,
  Switch,
  Dropdown,
  Avatar,
  Link,
} from '@nextui-org/react'
import toast from 'react-hot-toast'
import { NavLink, useLocation, useMatch, useResolvedPath } from 'react-router-dom'
import { useDarkMode } from 'usehooks-ts'
import i18n from '../../i18n'
import { logOut } from '../../storage/authSlice'
import { useAppDispatch, useAuth, useCurrentUser } from '../../storage/hooks'
import { MoonIcon } from '../Icons/MoonIcon'
import { SunIcon } from '../Icons/SunIcon'

const NavBarLink = ({ to, children }: { to: string; children: string }) => {
  const resolvedPath = useResolvedPath(to)
  const isActive = useMatch({ path: resolvedPath.pathname + "/*" })

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
  const darkMode = useDarkMode();
  const [auth, fetched] = useAuth();
  const user = useCurrentUser();

  const logoutHandle = async () => {
    const toastNotification = toast.loading('Cerrando sesión...')
    const action = await dispatch(logOut())

    if (logOut.fulfilled.match(action)) {
      toast.success('¡Hasta luego!', {
        id: toastNotification,
      })
      location.reload()
    } else {
      toast.error('Error inesperado', {
        id: toastNotification,
      })
    }
  }

  const dispatch = useAppDispatch()

  const collapseItems = [
    ['Inicio', '/'],
    ['Calculadora', '/calculator'],
    ['Mi Estimacion', '/estimation'],
    ['Mi declaración', '/mytaxincome']
  ]

  return (
    <Navbar isBordered variant="sticky">
      <Navbar.Toggle showIn="xs" />
      <Navbar.Brand>
        <Text b color="inherit">
          ERRENTA
        </Text>
      </Navbar.Brand>
      <Navbar.Content
        enableCursorHighlight
        activeColor="warning"
        hideIn="xs"
        variant="highlight-rounded"
      >
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
          <Link href="https://elizaasesores.com">
            Eliza Asesores
          </Link>
        </Navbar.Item>
        {auth && (
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
                    text={user?.name}
                  />
                </Dropdown.Trigger>
              </Navbar.Item>
              <Dropdown.Menu
                aria-label="User menu actions"
                color="secondary"
                onAction={logoutHandle}
              >
                <Dropdown.Item key="logout" color="error">
                  Log Out
                </Dropdown.Item>
              </Dropdown.Menu>
            </Dropdown>
          </Navbar.Content>
        )}
      </Navbar.Content>

      <Navbar.Collapse disableAnimation>
        {collapseItems.map((item, index) => (
          <NavBarCollapse key={index} to={item[1]}>
            {item[0]}
          </NavBarCollapse>
        ))}
      </Navbar.Collapse>
    </Navbar>
  )
}

export default Navigation