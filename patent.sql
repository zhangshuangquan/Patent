/*
Navicat MySQL Data Transfer

Source Server         : db
Source Server Version : 50617
Source Host           : 10.1.50.20:3306
Source Database       : patent

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2015-06-11 16:06:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for base_fee
-- ----------------------------
DROP TABLE IF EXISTS `base_fee`;
CREATE TABLE `base_fee` (
  `BASE_FEE_ID` int(11) NOT NULL,
  `PATENT_TYPE_ID` int(11) DEFAULT NULL,
  `FEE` decimal(6,2) NOT NULL COMMENT '全额',
  `YEAR_NUM` int(11) NOT NULL COMMENT '年次，从1开始',
  PRIMARY KEY (`BASE_FEE_ID`),
  KEY `FK_Reference_2` (`PATENT_TYPE_ID`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`PATENT_TYPE_ID`) REFERENCES `patent_type` (`PATENT_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='缴费基数';

-- ----------------------------
-- Records of base_fee
-- ----------------------------
INSERT INTO `base_fee` VALUES ('1', '1', '900.00', '1');
INSERT INTO `base_fee` VALUES ('2', '1', '900.00', '2');
INSERT INTO `base_fee` VALUES ('3', '1', '900.00', '3');
INSERT INTO `base_fee` VALUES ('4', '1', '1200.00', '4');
INSERT INTO `base_fee` VALUES ('5', '1', '1200.00', '5');
INSERT INTO `base_fee` VALUES ('6', '1', '1200.00', '6');
INSERT INTO `base_fee` VALUES ('7', '1', '2000.00', '7');
INSERT INTO `base_fee` VALUES ('8', '1', '2000.00', '8');
INSERT INTO `base_fee` VALUES ('9', '1', '2000.00', '9');
INSERT INTO `base_fee` VALUES ('10', '1', '4000.00', '10');
INSERT INTO `base_fee` VALUES ('11', '1', '4000.00', '11');
INSERT INTO `base_fee` VALUES ('12', '1', '4000.00', '12');
INSERT INTO `base_fee` VALUES ('13', '1', '6000.00', '13');
INSERT INTO `base_fee` VALUES ('14', '1', '6000.00', '14');
INSERT INTO `base_fee` VALUES ('15', '1', '6000.00', '15');
INSERT INTO `base_fee` VALUES ('16', '1', '8000.00', '16');
INSERT INTO `base_fee` VALUES ('17', '1', '8000.00', '17');
INSERT INTO `base_fee` VALUES ('18', '1', '8000.00', '18');
INSERT INTO `base_fee` VALUES ('19', '1', '8000.00', '19');
INSERT INTO `base_fee` VALUES ('20', '1', '8000.00', '20');
INSERT INTO `base_fee` VALUES ('21', '2', '600.00', '1');
INSERT INTO `base_fee` VALUES ('22', '2', '600.00', '2');
INSERT INTO `base_fee` VALUES ('23', '2', '600.00', '3');
INSERT INTO `base_fee` VALUES ('24', '2', '900.00', '4');
INSERT INTO `base_fee` VALUES ('25', '2', '900.00', '5');
INSERT INTO `base_fee` VALUES ('26', '2', '1200.00', '6');
INSERT INTO `base_fee` VALUES ('27', '2', '1200.00', '7');
INSERT INTO `base_fee` VALUES ('28', '2', '1200.00', '8');
INSERT INTO `base_fee` VALUES ('29', '2', '2000.00', '9');
INSERT INTO `base_fee` VALUES ('30', '2', '2000.00', '10');
INSERT INTO `base_fee` VALUES ('31', '3', '600.00', '1');
INSERT INTO `base_fee` VALUES ('32', '3', '600.00', '2');
INSERT INTO `base_fee` VALUES ('33', '3', '600.00', '3');
INSERT INTO `base_fee` VALUES ('34', '3', '900.00', '4');
INSERT INTO `base_fee` VALUES ('35', '3', '900.00', '5');
INSERT INTO `base_fee` VALUES ('36', '3', '1200.00', '6');
INSERT INTO `base_fee` VALUES ('37', '3', '1200.00', '7');
INSERT INTO `base_fee` VALUES ('38', '3', '1200.00', '8');
INSERT INTO `base_fee` VALUES ('39', '3', '2000.00', '9');
INSERT INTO `base_fee` VALUES ('40', '3', '2000.00', '10');

-- ----------------------------
-- Table structure for patent
-- ----------------------------
DROP TABLE IF EXISTS `patent`;
CREATE TABLE `patent` (
  `PATENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `APPLY_NUM` varchar(30) NOT NULL COMMENT '申请号（唯一，由税务局给定）',
  `NAME` varchar(100) NOT NULL COMMENT '专利名',
  `APPLY_DATE` date NOT NULL COMMENT '申请日期',
  `TOTAL_PAY` decimal(8,2) NOT NULL COMMENT '交税总额',
  `GRANT_FLAG_DATE` date DEFAULT NULL COMMENT '授权日',
  `GRANT_DATE` date NOT NULL COMMENT '授权通知日',
  `PATENT_TYPE_ID` int(11) NOT NULL COMMENT '专利类型id',
  `REMIND_TYPE` varchar(10) DEFAULT NULL COMMENT '提醒类型：3M/三个月 2M/两个月 1M/一个月 20D/20天 10D/10天 5D/5天 ',
  `PAY_STATUS` int(11) DEFAULT NULL COMMENT '缴费状态:已经交了多少年度的',
  `STATUS` int(11) NOT NULL COMMENT '专利状态：1/正常 2/失效',
  `PRIORITY_DATE` date DEFAULT NULL COMMENT '优先权日',
  PRIMARY KEY (`PATENT_ID`),
  KEY `FK_Reference_1` (`PATENT_TYPE_ID`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`PATENT_TYPE_ID`) REFERENCES `patent_type` (`PATENT_TYPE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COMMENT='专利表';

-- ----------------------------
-- Records of patent
-- ----------------------------
INSERT INTO `patent` VALUES ('150', '4654565.0', 'eeeeee', '2011-01-01', '360.00', null, '2012-02-02', '2', null, '2', '1', null);

-- ----------------------------
-- Table structure for patent_detail
-- ----------------------------
DROP TABLE IF EXISTS `patent_detail`;
CREATE TABLE `patent_detail` (
  `PATENT_DETAIL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PATENT_ID` int(30) NOT NULL,
  `YEAR_NUM` int(11) NOT NULL COMMENT '缴费第几年',
  `PAY_FLAG` char(255) NOT NULL COMMENT '是否已缴费',
  PRIMARY KEY (`PATENT_DETAIL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2266 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of patent_detail
-- ----------------------------
INSERT INTO `patent_detail` VALUES ('1636', '114', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1637', '114', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1638', '114', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1639', '114', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1640', '114', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1641', '114', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1642', '114', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1643', '114', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1644', '114', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1645', '114', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1646', '115', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1647', '115', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1648', '115', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1649', '115', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1650', '115', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1651', '115', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('1652', '115', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1653', '115', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1654', '115', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1655', '115', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1656', '115', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1657', '115', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1658', '115', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1659', '115', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1660', '115', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1661', '115', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1662', '115', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1663', '115', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1664', '115', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1665', '115', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1666', '116', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1667', '116', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1668', '116', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1669', '116', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1670', '116', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1671', '116', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('1672', '116', '7', 'Y');
INSERT INTO `patent_detail` VALUES ('1673', '116', '8', 'Y');
INSERT INTO `patent_detail` VALUES ('1674', '116', '9', 'Y');
INSERT INTO `patent_detail` VALUES ('1675', '116', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1676', '116', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1677', '116', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1678', '116', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1679', '116', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1680', '116', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1681', '116', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1682', '116', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1683', '116', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1684', '116', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1685', '116', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1686', '117', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1687', '117', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1688', '117', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1689', '117', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1690', '117', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1691', '117', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('1692', '117', '7', 'Y');
INSERT INTO `patent_detail` VALUES ('1693', '117', '8', 'Y');
INSERT INTO `patent_detail` VALUES ('1694', '117', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1695', '117', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1696', '117', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1697', '117', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1698', '117', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1699', '117', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1700', '117', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1701', '117', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1702', '117', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1703', '117', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1704', '117', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1705', '117', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1706', '118', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1707', '118', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1708', '118', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1709', '118', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1710', '118', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1711', '118', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('1712', '118', '7', 'Y');
INSERT INTO `patent_detail` VALUES ('1713', '118', '8', 'Y');
INSERT INTO `patent_detail` VALUES ('1714', '118', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1715', '118', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1716', '118', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1717', '118', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1718', '118', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1719', '118', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1720', '118', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1721', '118', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1722', '118', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1723', '118', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1724', '118', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1725', '118', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1726', '119', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1727', '119', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1728', '119', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1729', '119', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1730', '119', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1731', '119', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('1732', '119', '7', 'Y');
INSERT INTO `patent_detail` VALUES ('1733', '119', '8', 'Y');
INSERT INTO `patent_detail` VALUES ('1734', '119', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1735', '119', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1736', '119', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1737', '119', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1738', '119', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1739', '119', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1740', '119', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1741', '119', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1742', '119', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1743', '119', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1744', '119', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1745', '119', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1746', '120', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1747', '120', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1748', '120', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1749', '120', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1750', '120', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1751', '120', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1752', '120', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1753', '120', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1754', '120', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1755', '120', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1756', '120', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1757', '120', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1758', '120', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1759', '120', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1760', '120', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1761', '120', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1762', '120', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1763', '120', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1764', '120', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1765', '120', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1766', '121', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1767', '121', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1768', '121', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1769', '121', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1770', '121', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1771', '121', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1772', '121', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1773', '121', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1774', '121', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1775', '121', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1776', '121', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1777', '121', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1778', '121', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1779', '121', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1780', '121', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1781', '121', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1782', '121', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1783', '121', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1784', '121', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1785', '121', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1786', '122', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1787', '122', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1788', '122', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1789', '122', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1790', '122', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1791', '122', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1792', '122', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1793', '122', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1794', '122', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1795', '122', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1796', '122', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1797', '122', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1798', '122', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1799', '122', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1800', '122', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1801', '122', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1802', '122', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1803', '122', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1804', '122', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1805', '122', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1806', '123', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1807', '123', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1808', '123', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1809', '123', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1810', '123', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1811', '123', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1812', '123', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1813', '123', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1814', '123', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1815', '123', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1816', '123', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1817', '123', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1818', '123', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1819', '123', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1820', '123', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1821', '123', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1822', '123', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1823', '123', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1824', '123', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1825', '123', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1826', '124', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1827', '124', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1828', '124', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1829', '124', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1830', '124', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1831', '124', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1832', '124', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1833', '124', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1834', '124', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1835', '124', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1836', '124', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1837', '124', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1838', '124', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1839', '124', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1840', '124', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1841', '124', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1842', '124', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1843', '124', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1844', '124', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1845', '124', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1846', '125', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1847', '125', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1848', '125', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1849', '125', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1850', '125', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1851', '125', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1852', '125', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1853', '125', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1854', '125', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1855', '125', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1856', '125', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1857', '125', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1858', '125', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1859', '125', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1860', '125', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1861', '125', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1862', '125', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1863', '125', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1864', '125', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1865', '125', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1866', '126', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1867', '126', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1868', '126', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1869', '126', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1870', '126', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1871', '126', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1872', '126', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1873', '126', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1874', '126', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1875', '126', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1876', '126', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1877', '126', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1878', '126', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1879', '126', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1880', '126', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1881', '126', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1882', '126', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1883', '126', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1884', '126', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1885', '126', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1886', '127', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1887', '127', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1888', '127', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1889', '127', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1890', '127', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1891', '127', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1892', '127', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1893', '127', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1894', '127', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1895', '127', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1896', '127', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1897', '127', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1898', '127', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1899', '127', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1900', '127', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1901', '127', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1902', '127', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1903', '127', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1904', '127', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1905', '127', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1906', '128', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1907', '128', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1908', '128', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1909', '128', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1910', '128', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1911', '128', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1912', '128', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1913', '128', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1914', '128', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1915', '128', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1916', '128', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1917', '128', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1918', '128', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1919', '128', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1920', '128', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1921', '128', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1922', '128', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1923', '128', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1924', '128', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1925', '128', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1926', '129', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1927', '129', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1928', '129', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1929', '129', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1930', '129', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1931', '129', '6', 'N');
INSERT INTO `patent_detail` VALUES ('1932', '129', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1933', '129', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1934', '129', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1935', '129', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1936', '129', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1937', '129', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1938', '129', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1939', '129', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1940', '129', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1941', '129', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1942', '129', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1943', '129', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1944', '129', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1945', '129', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1946', '130', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1947', '130', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1948', '130', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1949', '130', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1950', '130', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1951', '130', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('1952', '130', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1953', '130', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1954', '130', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1955', '130', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1956', '130', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1957', '130', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1958', '130', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1959', '130', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1960', '130', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1961', '130', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1962', '130', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1963', '130', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1964', '130', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1965', '130', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1966', '131', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1967', '131', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1968', '131', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1969', '131', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1970', '131', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1971', '131', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('1972', '131', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1973', '131', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1974', '131', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1975', '131', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1976', '131', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1977', '131', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1978', '131', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1979', '131', '14', 'N');
INSERT INTO `patent_detail` VALUES ('1980', '131', '15', 'N');
INSERT INTO `patent_detail` VALUES ('1981', '131', '16', 'N');
INSERT INTO `patent_detail` VALUES ('1982', '131', '17', 'N');
INSERT INTO `patent_detail` VALUES ('1983', '131', '18', 'N');
INSERT INTO `patent_detail` VALUES ('1984', '131', '19', 'N');
INSERT INTO `patent_detail` VALUES ('1985', '131', '20', 'N');
INSERT INTO `patent_detail` VALUES ('1986', '132', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('1987', '132', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('1988', '132', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('1989', '132', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('1990', '132', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('1991', '132', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('1992', '132', '7', 'N');
INSERT INTO `patent_detail` VALUES ('1993', '132', '8', 'N');
INSERT INTO `patent_detail` VALUES ('1994', '132', '9', 'N');
INSERT INTO `patent_detail` VALUES ('1995', '132', '10', 'N');
INSERT INTO `patent_detail` VALUES ('1996', '132', '11', 'N');
INSERT INTO `patent_detail` VALUES ('1997', '132', '12', 'N');
INSERT INTO `patent_detail` VALUES ('1998', '132', '13', 'N');
INSERT INTO `patent_detail` VALUES ('1999', '132', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2000', '132', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2001', '132', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2002', '132', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2003', '132', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2004', '132', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2005', '132', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2006', '133', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2007', '133', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2008', '133', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2009', '133', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('2010', '133', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('2011', '133', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('2012', '133', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2013', '133', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2014', '133', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2015', '133', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2016', '133', '11', 'N');
INSERT INTO `patent_detail` VALUES ('2017', '133', '12', 'N');
INSERT INTO `patent_detail` VALUES ('2018', '133', '13', 'N');
INSERT INTO `patent_detail` VALUES ('2019', '133', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2020', '133', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2021', '133', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2022', '133', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2023', '133', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2024', '133', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2025', '133', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2026', '134', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2027', '134', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2028', '134', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2029', '134', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('2030', '134', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('2031', '134', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('2032', '134', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2033', '134', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2034', '134', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2035', '134', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2036', '134', '11', 'N');
INSERT INTO `patent_detail` VALUES ('2037', '134', '12', 'N');
INSERT INTO `patent_detail` VALUES ('2038', '134', '13', 'N');
INSERT INTO `patent_detail` VALUES ('2039', '134', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2040', '134', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2041', '134', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2042', '134', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2043', '134', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2044', '134', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2045', '134', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2046', '135', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2047', '135', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2048', '135', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2049', '135', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('2050', '135', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('2051', '135', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('2052', '135', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2053', '135', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2054', '135', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2055', '135', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2056', '135', '11', 'N');
INSERT INTO `patent_detail` VALUES ('2057', '135', '12', 'N');
INSERT INTO `patent_detail` VALUES ('2058', '135', '13', 'N');
INSERT INTO `patent_detail` VALUES ('2059', '135', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2060', '135', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2061', '135', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2062', '135', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2063', '135', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2064', '135', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2065', '135', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2066', '136', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2067', '136', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2068', '136', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2069', '136', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('2070', '136', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('2071', '136', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2072', '136', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2073', '136', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2074', '136', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2075', '136', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2076', '136', '11', 'N');
INSERT INTO `patent_detail` VALUES ('2077', '136', '12', 'N');
INSERT INTO `patent_detail` VALUES ('2078', '136', '13', 'N');
INSERT INTO `patent_detail` VALUES ('2079', '136', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2080', '136', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2081', '136', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2082', '136', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2083', '136', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2084', '136', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2085', '136', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2086', '137', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2087', '137', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2088', '137', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2089', '137', '4', 'N');
INSERT INTO `patent_detail` VALUES ('2090', '137', '5', 'N');
INSERT INTO `patent_detail` VALUES ('2091', '137', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2092', '137', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2093', '137', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2094', '137', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2095', '137', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2096', '138', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2097', '138', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2098', '138', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2099', '138', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('2100', '138', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('2101', '138', '6', 'Y');
INSERT INTO `patent_detail` VALUES ('2102', '138', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2103', '138', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2104', '138', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2105', '138', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2106', '138', '11', 'N');
INSERT INTO `patent_detail` VALUES ('2107', '138', '12', 'N');
INSERT INTO `patent_detail` VALUES ('2108', '138', '13', 'N');
INSERT INTO `patent_detail` VALUES ('2109', '138', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2110', '138', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2111', '138', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2112', '138', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2113', '138', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2114', '138', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2115', '138', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2116', '139', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2117', '139', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2118', '139', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2119', '139', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('2120', '139', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('2121', '139', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2122', '139', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2123', '139', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2124', '139', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2125', '139', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2126', '139', '11', 'N');
INSERT INTO `patent_detail` VALUES ('2127', '139', '12', 'N');
INSERT INTO `patent_detail` VALUES ('2128', '139', '13', 'N');
INSERT INTO `patent_detail` VALUES ('2129', '139', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2130', '139', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2131', '139', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2132', '139', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2133', '139', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2134', '139', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2135', '139', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2136', '140', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2137', '140', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2138', '140', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2139', '140', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('2140', '140', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('2141', '140', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2142', '140', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2143', '140', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2144', '140', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2145', '140', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2146', '140', '11', 'N');
INSERT INTO `patent_detail` VALUES ('2147', '140', '12', 'N');
INSERT INTO `patent_detail` VALUES ('2148', '140', '13', 'N');
INSERT INTO `patent_detail` VALUES ('2149', '140', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2150', '140', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2151', '140', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2152', '140', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2153', '140', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2154', '140', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2155', '140', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2156', '141', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2157', '141', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2158', '141', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2159', '141', '4', 'Y');
INSERT INTO `patent_detail` VALUES ('2160', '141', '5', 'Y');
INSERT INTO `patent_detail` VALUES ('2161', '141', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2162', '141', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2163', '141', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2164', '141', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2165', '141', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2166', '141', '11', 'N');
INSERT INTO `patent_detail` VALUES ('2167', '141', '12', 'N');
INSERT INTO `patent_detail` VALUES ('2168', '141', '13', 'N');
INSERT INTO `patent_detail` VALUES ('2169', '141', '14', 'N');
INSERT INTO `patent_detail` VALUES ('2170', '141', '15', 'N');
INSERT INTO `patent_detail` VALUES ('2171', '141', '16', 'N');
INSERT INTO `patent_detail` VALUES ('2172', '141', '17', 'N');
INSERT INTO `patent_detail` VALUES ('2173', '141', '18', 'N');
INSERT INTO `patent_detail` VALUES ('2174', '141', '19', 'N');
INSERT INTO `patent_detail` VALUES ('2175', '141', '20', 'N');
INSERT INTO `patent_detail` VALUES ('2176', '142', '1', 'N');
INSERT INTO `patent_detail` VALUES ('2177', '142', '2', 'N');
INSERT INTO `patent_detail` VALUES ('2178', '142', '3', 'N');
INSERT INTO `patent_detail` VALUES ('2179', '142', '4', 'N');
INSERT INTO `patent_detail` VALUES ('2180', '142', '5', 'N');
INSERT INTO `patent_detail` VALUES ('2181', '142', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2182', '142', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2183', '142', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2184', '142', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2185', '142', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2186', '143', '1', 'N');
INSERT INTO `patent_detail` VALUES ('2187', '143', '2', 'N');
INSERT INTO `patent_detail` VALUES ('2188', '143', '3', 'N');
INSERT INTO `patent_detail` VALUES ('2189', '143', '4', 'N');
INSERT INTO `patent_detail` VALUES ('2190', '143', '5', 'N');
INSERT INTO `patent_detail` VALUES ('2191', '143', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2192', '143', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2193', '143', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2194', '143', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2195', '143', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2206', '145', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2207', '145', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2208', '145', '3', 'Y');
INSERT INTO `patent_detail` VALUES ('2209', '145', '4', 'N');
INSERT INTO `patent_detail` VALUES ('2210', '145', '5', 'N');
INSERT INTO `patent_detail` VALUES ('2211', '145', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2212', '145', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2213', '145', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2214', '145', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2215', '145', '10', 'N');
INSERT INTO `patent_detail` VALUES ('2256', '150', '1', 'Y');
INSERT INTO `patent_detail` VALUES ('2257', '150', '2', 'Y');
INSERT INTO `patent_detail` VALUES ('2258', '150', '3', 'N');
INSERT INTO `patent_detail` VALUES ('2259', '150', '4', 'N');
INSERT INTO `patent_detail` VALUES ('2260', '150', '5', 'N');
INSERT INTO `patent_detail` VALUES ('2261', '150', '6', 'N');
INSERT INTO `patent_detail` VALUES ('2262', '150', '7', 'N');
INSERT INTO `patent_detail` VALUES ('2263', '150', '8', 'N');
INSERT INTO `patent_detail` VALUES ('2264', '150', '9', 'N');
INSERT INTO `patent_detail` VALUES ('2265', '150', '10', 'N');

-- ----------------------------
-- Table structure for patent_type
-- ----------------------------
DROP TABLE IF EXISTS `patent_type`;
CREATE TABLE `patent_type` (
  `PATENT_TYPE_ID` int(11) NOT NULL,
  `PATENT_TYPE_NAME` varchar(20) NOT NULL,
  `PAY_DISCOUNT` decimal(4,3) NOT NULL COMMENT '减缓率',
  `REMIND_TYPE` varchar(5) DEFAULT NULL COMMENT '提醒类型：3M/三个月 2M/两个月 1M/一个月 20D/20天 10D/10天 5D/5天 ',
  `VALID_YEARS` int(2) NOT NULL,
  PRIMARY KEY (`PATENT_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='专利类型和折扣';

-- ----------------------------
-- Records of patent_type
-- ----------------------------
INSERT INTO `patent_type` VALUES ('1', '发明', '0.300', '1M', '20');
INSERT INTO `patent_type` VALUES ('2', '实用新型', '0.300', '1M', '10');
INSERT INTO `patent_type` VALUES ('3', '外观设计', '0.300', '1M', '10');
