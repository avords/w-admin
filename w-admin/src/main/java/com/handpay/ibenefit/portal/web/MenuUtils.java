package com.handpay.ibenefit.portal.web;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.swing.tree.DefaultMutableTreeNode;

import com.handpay.ibenefit.framework.util.DomainUtils;
import com.handpay.ibenefit.framework.util.MessageUtils;
import com.handpay.ibenefit.portal.entity.MenuImage;
import com.handpay.ibenefit.security.entity.Menu;

public final class MenuUtils {
	private MenuUtils() {
	}

	public static List<Menu> getSubMenus(String parentPath, List<Menu> allPermissionMenus) {
		List<Menu> menus = new ArrayList<Menu>();
		if (null != allPermissionMenus) {
			for (Menu menu : allPermissionMenus) {
				if (menu.getPath().startsWith(parentPath) && isNeedDisplayInSystemMenu(menu)) {
					menus.add(menu);
				}
			}
		}
		return menus;
	}

	public static DefaultMutableTreeNode getMenuTree(Menu parentMenu, List<Menu> allPermissionMenus) {

		if (parentMenu != null) {
			DefaultMutableTreeNode treeNode = new DefaultMutableTreeNode(parentMenu);
			List<Menu> menus = new ArrayList<Menu>();
			for (Menu menu : allPermissionMenus) {
				if (menu.getParentId().equals(parentMenu.getObjectId())) {
					menus.add(menu);
				}
			}
			if (menus.size() > 0) {
				for (Menu menu : menus) {
					treeNode.add(getMenuTree(menu, allPermissionMenus));
				}
			}
			return treeNode;
		}
		return null;
	
		/*
		if (null != allPermissionMenus) {
			for (Menu menu : allPermissionMenus) {
				if (parentId == menu.getParentId()) {
					parentMenu = menu;
					break;
				}
			}
		}
		DefaultMutableTreeNode treeNode = getMenuTree(parentMenu, allPermissionMenus);
		treeNode = buildNotEmptyTree(treeNode);
		return treeNode;
	*/}

	public static List<Menu> getFirstLevelMenu(List<Menu> allPermissionMenus) {
		List<Menu> menus = new ArrayList<Menu>();
		if (null != allPermissionMenus) {
			for (Menu menu : allPermissionMenus) {
				if (menu.getParentId().equals(Menu.ROOT_PLATEFORM_ADMIN.getObjectId())) {
					if (Menu.TYPE_MENU == menu.getType()) {
						menus.add(menu);
					} else {
						List<Menu> sub = getSubMenus(menu.getObjectId(), allPermissionMenus);
						if (sub.size() > 0) {
							menus.add(menu);
						}
					}
				}
			}
		}
		return menus;
	}

	private static boolean isNeedDisplayInSystemMenu(Menu menu) {
		return true;
//		return (null == menu.getDisplayPosition() || Menu.DISPLAY_POSITION_SYSTEM_MENU == menu.getDisplayPosition());
	}

	public static DefaultMutableTreeNode getMenuTree(long parentId, Long currentModuleId, List<Menu> allPermissionMenus) {
		Menu parentMenu = null;
		if (null != allPermissionMenus) {
			for (Menu menu : allPermissionMenus) {
				if (parentId == menu.getObjectId()) {
					parentMenu = menu;
					break;
				}
			}
		}
		DefaultMutableTreeNode treeNode = getMenuTree(parentMenu, allPermissionMenus);
		treeNode = buildNotEmptyTree(treeNode);
		return treeNode;
	}

	private static DefaultMutableTreeNode buildNotEmptyTree(DefaultMutableTreeNode node) {
		List<DefaultMutableTreeNode> needDeleted = new ArrayList<DefaultMutableTreeNode>();
		if (null != node) {
			for (Enumeration<DefaultMutableTreeNode> e = node.children(); e.hasMoreElements();) {
				DefaultMutableTreeNode current = e.nextElement();
				DefaultMutableTreeNode childMenu = buildNotEmptyTree(current);
				if (null == childMenu) {
					needDeleted.add(current);
				}
			}
			for (DefaultMutableTreeNode current : needDeleted) {
				node.remove(current);
			}
			if (node.children().hasMoreElements() || Menu.TYPE_MENU == ((Menu) node.getUserObject()).getType()) {
				return node;
			} else {
				return null;
			}
		}
		return node;
	}

/*	private static DefaultMutableTreeNode getMenuTree(Menu parentMenu, List<Menu> allPermissionMenus) {
		if (parentMenu != null) {
			DefaultMutableTreeNode treeNode = new DefaultMutableTreeNode(parentMenu);
			List<Menu> menus = new ArrayList<Menu>();
			for (Menu menu : allPermissionMenus) {
				if (menu.getParentId().equals(parentMenu.getObjectId())) {
					menus.add(menu);
				}
			}
			if (menus.size() > 0) {
				for (Menu menu : menus) {
					treeNode.add(getMenuTree(menu, allPermissionMenus));
				}
			}
			return treeNode;
		}
		return null;
	}*/

	/**
	 * 此方法会1级菜单的ID号，遍历其所有的2，3级子节点
	 * 
	 * @param treeNode
	 *            1级菜单ID封装的对象
	 * @param treeHtml
	 * @param locale
	 */
	public static void generateTreeHtml(DefaultMutableTreeNode treeNode, StringBuilder treeHtml, Locale locale) {
		if (null != treeNode && null != treeNode.getUserObject()) {
			if (treeNode.getChildCount() > 0) {
				Enumeration num = treeNode.children();
				while (num.hasMoreElements()) {
					treeNode = (DefaultMutableTreeNode) num.nextElement();
					if (null != treeNode && null != treeNode.getUserObject()&&treeNode.getChildCount()>0) {
						Menu menu = (Menu) treeNode.getUserObject();
						treeHtml.append("<li id=\"menuli_" + menu.getObjectId() + "\" class='treeview'>");
						if (Menu.TYPE_FOLDER == menu.getType()) {
							treeHtml.append("<a href=")
									.append("\"javascript:clickMenu('").append(menu.getObjectId()+"')\"").append(">"
									+ "<i class='fa fa-laptop fa-plus'></i><span>"
									+ MessageUtils.getMessage(menu.getName(), locale) + "</span>"
									+ "<i class='fa fa-angle-left pull-right'></i>" + "</a>");
						} else {
							treeHtml.append("<a href=")
							.append("\"javascript:clickMenu('").append(menu.getObjectId()+"')\"").append(">"
							+ "<i class='fa fa-laptop'></i><span>"
							+ MessageUtils.getMessage(menu.getName(), locale) + "</span>"
							+ "<i class='fa fa-angle-left pull-right'></i>" + "</a>");
						}
						if (treeNode.getChildCount() > 0) {
							treeHtml.append("<ul class='treeview-menu'>");
							Enumeration dd = treeNode.children();
							while (dd.hasMoreElements()) {
								generateTreeHtml0((DefaultMutableTreeNode) dd.nextElement(), treeHtml, locale,menu.getName());
							}
							treeHtml.append("</ul>");
						}
						treeHtml.append("</li>");
					}
				}
			}
		}
	}

	public static void generateTreeHtml0(DefaultMutableTreeNode treeNode, StringBuilder treeHtml, Locale locale,String parentName) {
		if (null != treeNode && null != treeNode.getUserObject()) {
			Menu menu = (Menu) treeNode.getUserObject();
			treeHtml.append("<li id=\"menu_" + menu.getObjectId() + "\">");
			if (Menu.TYPE_FOLDER == menu.getType()) {
				treeHtml.append("<a href='#'>");
			} else {
				treeHtml.append("<a id=\"menu_" + menu.getObjectId() + "\" href=")
						.append("\"javascript:clickSubMenu('").append(menu.getObjectId()+"','"
												+ menu.getParentId()+"','"
												+ menu.getFullUrl()+"','"
												+ parentName+"','"
												+ menu.getName()+"')\"").append(">");
			}
//			treeHtml.append("<i class='fa fa-circle-o'></i>");
			treeHtml.append(MessageUtils.getMessage(menu.getName(), locale));
			treeHtml.append("</a>");
			treeHtml.append("</li>");
		}
	}

	public static void generateTreeHtml(DefaultMutableTreeNode treeNode, StringBuilder treeHtml,
			List<MenuImage> menuImageList, String skinColor, Long moduleId) {
		Map<String, String> menuImageMap = new HashMap<String, String>(menuImageList.size());
		for (int i = 0, n = menuImageList.size(); i < n; i++) {
			MenuImage image = menuImageList.get(i);
			menuImageMap.put(image.getModuleId()
					+ (image.getType().equals(MenuImage.MENU_IMAGE_TYPE_MENU) ? "_" + image.getMenuId() : ""),
					image.getImageName());
		}
		generateHtml(treeNode, treeHtml, menuImageMap, skinColor, moduleId);
	}

	public static void generateHtml(DefaultMutableTreeNode treeNode, StringBuilder treeHtml,
			Map<String, String> menuImageMap, String skinColor, Long moduleId) {
		if (null != treeNode && null != treeNode.getUserObject()) {
			Menu menu = (Menu) treeNode.getUserObject();
			treeHtml.append("<li>");
			treeHtml.append("");
			if (Menu.TYPE_FOLDER == menu.getType()) {
				treeHtml.append("<span class=\"folder\">");
				treeHtml.append("<img src=\"").append(DomainUtils.getStaticDomain()).append("theme/").append(skinColor)
						.append("/images/icon/").append(getImgeName(moduleId, menu, menuImageMap)).append("\"></img>");
				treeHtml.append(menu.getName()).append("</span>");
			} else {
				treeHtml.append("<img src=\"").append(DomainUtils.getStaticDomain()).append("theme/").append(skinColor)
						.append("/images/icon/").append(getImgeName(moduleId, menu, menuImageMap)).append("\"></img>");
				treeHtml.append("<a href=\"javascript:void(0)\"  onclick=\"toMenu('")
						.append(DomainUtils.getDynamicDomain()).append("/portal/wait?menuId=")
						.append(menu.getObjectId()).append("')\">").append(menu.getName()).append("</a>");
			}
			if (treeNode.getChildCount() > 0) {
				treeHtml.append("<ul>");
				Enumeration num = treeNode.children();
				while (num.hasMoreElements()) {
					generateHtml((DefaultMutableTreeNode) num.nextElement(), treeHtml, menuImageMap, skinColor,
							moduleId);
				}
				treeHtml.append("</ul>");
			}
			treeHtml.append("</li>");
		}
	}

	public static String getImgeName(Long moduleId, Menu menu, Map<String, String> menuImageMap) {
		if (moduleId == null) {
			return MenuImage.DEFAULT_IMAGE_NAME;
		}
		StringBuilder key = new StringBuilder(moduleId.toString());
		if (null != menu.getObjectId()) {
			key.append("_" + menu.getObjectId());
		}
		String result = menuImageMap.get(key.toString());
		if (result == null) {
			result = menuImageMap.get(moduleId.toString());
			if (result == null) {
				if (Menu.TYPE_FOLDER == menu.getType()) {
					result = "folder.gif";
				} else {
					result = "file.gif";
				}
			}
		}
		return result;
	}

/*	public static List<Menu> getTabMenus(List<Menu> allPermissionMenus, String parentPath) {
		List<Menu> result = new ArrayList<Menu>();
		for (Menu menu : allPermissionMenus) {
			if (Menu.TYPE_MENU == menu.getType()
					&& (null != menu.getDisplayPosition() && (Menu.DISPLAY_POSITION_TAB == menu.getDisplayPosition() || Menu.DISPLAY_POSITION_BOTH == menu
							.getDisplayPosition()))) {
				if ((parentPath + Menu.PATH_SEPARATOR + menu.getName()).equals(menu.getPath())) {
					result.add(menu);
				}
			}
		}
		return result;
	}*/

	public static List<Menu> getSubMenus(Long parentId, List<Menu> allPermissionMenus) {
		List<Menu> menus = new ArrayList<Menu>();
		if (null != allPermissionMenus) {
			for (Menu menu : allPermissionMenus) {
				if (parentId.equals(menu.getParentId()) && isNeedDisplayInSystemMenu(menu)) {
					if (Menu.TYPE_FOLDER == menu.getType()) {
						List<Menu> sub = getSubMenus(menu.getObjectId(), allPermissionMenus);
						if (sub.size() > 0) {
							menus.add(menu);
							menus.addAll(sub);
						}
					} else {
						menus.add(menu);
					}
				}
			}
		}
		return menus;
	}

	public static String generateDtreeHtml(List<Menu> menus, Map<String, String> menuImageMap, Long moduleId,
			String skinColor) {
		StringBuilder builder = new StringBuilder(200);
		for (Menu menu : menus) {
			builder.append("d.add(").append(menu.getObjectId()).append(",").append(menu.getParentId()).append(",'")
					.append(menu.getName()).append("'");
			if (Menu.TYPE_MENU == menu.getType()) {
				builder.append(",'navToMenu(" + menu.getObjectId() + ")','','','','")
						.append(DomainUtils.getStaticDomain()).append("theme/").append(skinColor)
						.append("/images/icon/").append(MenuUtils.getImgeName(moduleId, menu, menuImageMap))
						.append("'");
			} else {
				builder.append(",'void(0)'");
			}
			builder.append(");\n");
		}
		return builder.toString();
	}

	public static Menu getTop(List<Menu> menus, Menu menu) {
		if (menu == null || menu.getParentId() == null || menu.getParentId() == Menu.ROOT_PLATEFORM_ADMIN.getObjectId().intValue()) {
			return menu;
		} else {
			for (Menu temp : menus) {
				if (temp.getObjectId().equals(menu.getParentId())) {
					return getTop(menus, temp);
				}
			}
			return menu;
		}

	}

	public static Menu getTop(List<Menu> menus, long menuId) {
		Menu menu = null;
		for (Menu temp : menus) {
			if (temp.getObjectId() == menuId) {
				menu = temp;
			}
		}
		if (menu == null || menu.getParentId() == null || menu.getParentId() == Menu.ROOT_PLATEFORM_ADMIN.getObjectId().intValue()) {
			return menu;
		} else {
			for (Menu temp : menus) {
				if (temp.getObjectId().equals(menu.getParentId())) {
					return getTop(menus, temp);
				}
			}
			return menu;
		}

	}

	public static void getParent(List<Menu> menus, Menu menu, List<Menu> tree) {
		if (menu == null || menu.getParentId().equals(Menu.ROOT_PLATEFORM_ADMIN.getObjectId())) {
			return;
		} else {
			for (Menu temp : menus) {
				if (temp.getObjectId().equals(menu.getParentId())) {
					getParent(menus, temp, tree);
					tree.add(temp);
				}
			}
		}

	}

	public static Menu getByObjectId(List<Menu> menus, Long menuId) {
		Menu menu = null;
		for (Menu m : menus) {
			if (m.getObjectId().equals(menuId)) {
				menu = m;
				break;
			}
		}
		return menu;
	}
}
