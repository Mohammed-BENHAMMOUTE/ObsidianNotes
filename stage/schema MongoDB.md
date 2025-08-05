
```json
{
 "_id": ObjectId("..."),
 "created_at": ISODate("2024-01-15T10:30:00Z"),
 "invoice_number": "INV-2024-001",
 "invoice_date": ISODate("2024-01-15T00:00:00Z"),
 "vendor_name": "Acme Corporation",
 "total_amount": 1080.00,
 "currency": "MAD",
 "items": [
   {
     "description": "Web Development Services",
     "quantity": 40,
     "unit_price": 25.00,
     "total": 1000.00
   }
 ],
 "category": "Professional Services",
 "tags": ["Furniture", "monthly-service"],
 "source_type": "pdf/image",
 "status": "processed"
}
```


- **PyMuPDF**: Fast PDF processing, handles most PDF formats
- **Tesseract**: Industry standard OCR, free and reliable
- **OpenCV**: Improves OCR accuracy with image preprocessing
- **OpenAI API**: Handles the complex field mapping you want to avoid
// - **Celery + Redis**: Keeps API responsive during heavy processing  // we only need this if we are using microservices
- **MongoDB**: Perfect for storing flexible invoice structures
- **React**: Modern UI for file upload and invoice management