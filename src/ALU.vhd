----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal result: signed(7 downto 0);
    signal carry: STD_LOGIC;
    signal overflow: STD_LOGIC;
begin
    process(i_A, i_B, i_op)
        variable A, B: signed(7 downto 0);
        variable sum: signed(8 downto 0);
    begin
        A := signed(i_A);
        B := signed(i_B);
        case i_op is
            when "000" =>  -- ADD
                sum := ('0' & A) + ('0' & B);
                result <= sum(7 downto 0);
                carry <= sum(8);
                if (A(7) = B(7)) and (sum(7) /= A(7)) then
                    overflow <= '1';
                else
                    overflow <= '0';
                end if;
 
            when "001" =>  -- SUB
                sum := ('0' & A) - ('0' & B);
                result <= sum(7 downto 0);
                carry <= sum(8);  -- Borrow
                if (A(7) /= B(7)) and (sum(7) /= A(7)) then
                    overflow <= '1';
                else
                    overflow <= '0';
                end if;
 
            when others =>
                result <= (others => '0');
                carry <= '0';
                overflow <= '0';
        end case;
 
        -- Flags: Z C V N
        if result = 0 then
            o_flags(0) <= '1'; -- Zero
        else
            o_flags(0) <= '0';
        end if;
 
        o_flags(1) <= carry;         -- Carry
        o_flags(2) <= overflow;      -- Overflow
        o_flags(3) <= result(7);     -- Negative
 
        o_result <= std_logic_vector(result);
    end process;
end Behavioral;









