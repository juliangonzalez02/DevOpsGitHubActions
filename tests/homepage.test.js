import { describe, expect, it } from "vitest";
import { add } from "../src/homepage.js";


describe("add", () => {
    it("adds two numbers", () => {
        expect(add(2, 3)).toBe(5);
    });
});
/*"use strict";

function main()
{
    document.getElementById("txtOp1").value = Number(10);
    document.getElementById("colors").value = "Blue";
    document.getElementById("baseBot").checked = true;

    document.getElementById("drawTri").onclick = selectPosition;
}

function selectPosition()
{
    let number = Number(document.getElementById("txtOp1").value);
    let limit = 5;
    let numPosition;
    let position = document.getElementsByName("base");
    let selectedPosition;

    for(let i=0;i<position.length;i++){
        if(position[i].checked){
            selectedPosition = position[i].value;
            break;
        }
    }

    switch(selectedPosition){
        case "bottom":
            numPosition = 1;
            break;
        case "top":
            numPosition = 2;
            break;
    }

    //selectedColor();
    drawTriangle(numPosition,limit,number);
    
}

/*function selectedColor()
{
    let numColor;
    let color = document.getElementsByName("color");
    let selectedColor;

    for(let i=0;i<color.length;i++){
        if(color[i].checked){
            selectedColor = color[i].value;
            break;
        }
    }

    switch(selectedColor){
        case "r":
            numColor = 1;
            break;
        case "b":
            numColor = 2;
            break;
        case "g":
            numColor = 3;
            break;
    }

    alert(numColor);
}*

function drawTriangle(numPosition,limit,number)
{
    if(numPosition==1){
        for(let j=limit; j>=0; j--){
            for(let z=1; z<=j; z++){
                document.writeln(number);
                number++;
            }
            document.writeln("<br>");
        }
    }else if(numPosition==2){
        for(let j=1; j<=limit; j++){
            for(let z=1; z<=j; z++){
                document.writeln(number);
                number++;
            }
            document.writeln("<br>");
        }
    }
}*/