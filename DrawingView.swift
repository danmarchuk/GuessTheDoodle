//
//  DrawingView.swift
//  GuessTheDoodle
//
//  Created by Данік on 18/01/2024.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var matchManager: MatchManager
        
        init(matchManager: MatchManager) {
            self.matchManager = matchManager
        }
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            // TODO: send the new drawing data
        }
    }
    
    var canvasView = PKCanvasView()
    
    @ObservedObject var matchManager: MatchManager
    @Binding var eraserEnabled: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(matchManager: matchManager)
    }
    
    func makeUIView(context: Context) -> PKCanvasView  {
        // tak input from both pen and finger
        canvasView.drawingPolicy = .anyInput
        
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
        
        canvasView.isUserInteractionEnabled = matchManager.currentlyDrawing
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // TODO: handle various updates
        
        canvasView.tool = eraserEnabled ? PKEraserTool(.vector) : PKInkingTool(.pen, color: .black, width: 5)
    }
}

struct DrawingView_previews: PreviewProvider {
    @State static var eraser = false
    static var previews: some View {
        DrawingView(matchManager: MatchManager(), eraserEnabled: $eraser)
    }
}
