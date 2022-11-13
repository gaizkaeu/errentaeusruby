import {
  Navbar,
  Text,
  Switch,
  Dropdown,
  Avatar,
  Link,
} from "@nextui-org/react";
import { Key } from "react";
import { useTranslation } from "react-i18next";
import {
  NavLink,
  useMatch,
  useNavigate,
  useResolvedPath,
} from "react-router-dom";
import { useDarkMode } from "usehooks-ts";
import { useAuth } from "../../hooks/authHook";
import { MoonIcon } from "../Icons/MoonIcon";
import { SunIcon } from "../Icons/SunIcon";

const NavBarLink = ({ to, children }: { to: string; children: string }) => {
  const resolvedPath = useResolvedPath(to);
  const isActive = useMatch({ path: resolvedPath.pathname + "/*" });

  return (
    <Navbar.Link isActive={isActive ? true : false} as={NavLink} to={to}>
      {children}
    </Navbar.Link>
  );
};

const NavBarCollapse = ({ to, children }: { to: string; children: string }) => {
  const resolvedPath = useResolvedPath(to);
  const isActive = useMatch({ path: resolvedPath.pathname });

  return (
    <Navbar.CollapseItem
      activeColor="warning"
      isActive={isActive ? true : false}
      as={NavLink}
      to={to}
    >
      {children}
    </Navbar.CollapseItem>
  );
};

const Navigation = () => {
  const darkMode = useDarkMode();
  const { status, actions, currentUser } = useAuth();
  const { t } = useTranslation();
  const nav = useNavigate();

  const collapseItems = [
    [t("homepage.navbar"), "/"],
    [t("calculator.title"), "/calculator"],
    [t("estimation.title"), "/estimation"],
    [t("taxincome.title"), "/mytaxincome"],
  ];

  const dropdownActions = (key: Key) => {
    switch (key) {
      case "logout":
        actions.logOut();
        break;
      case "profile":
        nav("/profile");
        break;
    }
  };

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
        <Switch
          checked={darkMode.isDarkMode}
          onChange={darkMode.toggle}
          button-name="night-mode"
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
        <Navbar.Item hideIn="xs">
          <Link href="https://elizaasesores.com">Eliza Asesores</Link>
        </Navbar.Item>
        {status.fetched && status.loggedIn && (
          <Navbar.Content
            css={{
              "@xs": {
                w: "12%",
                jc: "flex-end",
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
                    text={currentUser?.name}
                  />
                </Dropdown.Trigger>
              </Navbar.Item>
              <Dropdown.Menu
                aria-label="User menu actions"
                color="secondary"
                onAction={dropdownActions}
              >
                <Dropdown.Item key="profile">
                  {t("navbar.myProfile")}
                </Dropdown.Item>
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
  );
};

export default Navigation;
